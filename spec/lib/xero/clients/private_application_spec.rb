require 'spec_helper'

describe Xero::Clients::PrivateApplication do

  let(:client) { Xero::Clients::PrivateApplication.new }

  describe '#save' do
    before { configure }

    let(:item) do
      Xero::Models::Item.new code: 'test-product',
        description: 'just testing',
        purchase_detail: purchase_detail_attributes,
        sales_detail: sales_detail_attributes
    end

    let(:purchase_detail_attributes) do
      { unit_price: 100, account_code: '620', tax_type: 'NONE' }
    end

    let(:sales_detail_attributes) do
      { unit_price: 550, account_code: '200', tax_type: 'NONE' }
    end

    before do
      VCR.use_cassette('create_item') do
        client.save(item)
      end
    end

    it 'should populate the item id' do
      item.id.should_not be_blank
    end

    it 'should be persisted' do
      item.should be_persisted
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
      items.first.purchase_detail.should be_a(Xero::Models::ItemDetail)
    end

    it 'should populate the item sales detail' do
      items.first.sales_detail.should be_a(Xero::Models::ItemDetail)
    end

    it 'should populate the item purchase detail account code' do
      items.first.purchase_detail.account_code.should_not be_blank
    end
  end
end
