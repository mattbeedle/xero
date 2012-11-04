require 'spec_helper'

describe Xero::Clients::PrivateApplication do

  let(:client) { Xero::Clients::PrivateApplication.new }

  describe '#contacts' do
    before { configure }

    let(:contacts) do
      VCR.use_cassette('contacts') { client.contacts }
    end

    it 'should return an array' do
      contacts.should be_a(Array)
    end

    it 'should contain contacts' do
      contacts.first.should be_a(Xero::Models::Contact)
    end

    it 'should populate the contacts id' do
      contacts.first.id.should_not be_blank
    end
  end

  describe '#get_contact' do
    before { configure }

    let(:contacts) do
      VCR.use_cassette('contacts') { client.contacts }
    end

    let(:contact) do
      VCR.use_cassette('contact') do
        client.get_contact(contacts.first.id)
      end
    end

    it 'should return a contact' do
      contact.should be_a(Xero::Models::Contact)
    end

    it 'should populate the contact id' do
      contact.id.should_not be_blank
    end

    it 'should populate the contact addresses' do
      contact.addresses.first.should be_a(Xero::Models::Address)
    end
  end

  describe '#get_invoice' do
    before { configure }

    let(:invoice) do
      VCR.use_cassette('get_invoice') do
        client.get_invoice('7f9e9823-f6d7-4302-90a1-ba59f6884ce9')
      end
    end

    it 'should return an invoice' do
      invoice.should be_a(Xero::Models::Invoice)
    end

    it 'should populate the type' do
      invoice.type.should_not be_blank
    end

    it 'should populate the date' do
      invoice.date.should_not be_blank
    end

    it 'should populate the due date' do
      invoice.due_date.should_not be_blank
    end

    it 'should populate the invoice number' do
      invoice.invoice_number.should_not be_blank
    end

    it 'should populate the total' do
      invoice.total.should_not be_blank
    end

    it 'should populate the currency code' do
      invoice.currency_code.should_not be_blank
    end

    it 'should populate the id' do
      invoice.id.should_not be_blank
    end

    it 'should populate the total tax' do
      invoice.total_tax.should_not be_blank
    end

    it 'should populate the invoice status' do
      invoice.status.should eql('AUTHORISED')
    end

    it 'should populate the invoice contact' do
      invoice.contact.should be_a(Xero::Models::Contact)
    end

    it 'should populate the contact data' do
      invoice.contact.id.should_not be_blank
    end
  end

  describe '#invoices' do
    before { configure }

    let(:invoices) do
      VCR.use_cassette('invoices') { client.invoices }
    end

    it 'should return an array' do
      invoices.should be_a(Array)
    end

    it 'should contain invoices' do
      invoices.first.should be_a(Xero::Models::Invoice)
    end

    it 'should populate the invoice data' do
      invoices.first.id.should_not be_blank
    end
  end

  describe '#save' do
    before { configure }

    context 'when saving an item' do
      let(:item) do
        Xero::Models::Item.new code: 'test-product',
          description: 'just testing',
          purchase_details: purchase_detail_attributes,
          sales_details: sales_detail_attributes
      end

      let(:purchase_detail_attributes) do
        { unit_price: 100, account_code: '620', tax_type: 'NONE' }
      end

      let(:sales_detail_attributes) do
        { unit_price: 550, account_code: '200', tax_type: 'NONE' }
      end

      before do
        VCR.use_cassette('create_item') { client.save(item) }
      end

      it 'should populate the item id' do
        item.id.should_not be_blank
      end

      it 'should be persisted' do
        item.should be_persisted
      end
    end

    context 'when saving an invoice' do
      let(:invoice) do
        Xero::Models::Invoice.new(
          type: 'ACCREC', contact: contact, line_items: line_items
        )
      end

      let(:contact) do
        Xero::Models::Contact.new(name: 'Xero Gem Test Contact')
      end

      let(:line_items) { [line_item] }

      let(:line_item) do
        Xero::Models::LineItem.new(
          description: 'A test line item from the xero gem',
          quantity: 2.0,
          unit_amount: 150.5,
          account_code: 200
        )
      end

      before do
        VCR.use_cassette('save_invoice') { client.save(invoice) }
      end

      it 'should persist the invoice' do
        invoice.should be_persisted
      end

      it 'should populate the contact id' do
        invoice.contact.id.should_not be_blank
      end
    end
  end

  describe '#get_item' do

    before { configure }

    let(:item) do
      client.get_item '99213658-83c4-438a-b104-1172b1e69790'
    end

    it 'should return an item' do
      VCR.use_cassette('get_item') do
        item.should be_a(Xero::Models::Item)
      end
    end
  end

  describe '#items' do
    before { configure }

    let(:items) do
      VCR.use_cassette('get_items') { client.items }
    end

    it 'should return an array' do
      items.should be_a(Array)
    end

    it 'should contain items' do
      items.first.should be_a(Xero::Models::Item)
    end

    it 'should populate the id' do
      items.first.id.should_not be_blank
    end

    it 'should populate the item code' do
      items.first.code.should_not be_blank
    end

    it 'should populate the item description' do
      items.first.description.should_not be_blank
    end

    it 'should populate the item purchase detail' do
      items.first.purchase_details.should be_a(Xero::Models::ItemDetail)
    end

    it 'should populate the item sales detail' do
      items.first.sales_details.should be_a(Xero::Models::ItemDetail)
    end

    it 'should populate the item purchase detail account code' do
      items.first.purchase_details.account_code.should_not be_blank
    end
  end
end
