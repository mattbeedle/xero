require 'spec_helper'

describe Xero::Models::Item do

  describe 'validations' do
    it { should validate_presence_of(:code) }
  end

  describe 'to_xero_xml' do
    let(:item) do
      Xero::Models::Item.new(
        purchase_details: purchase_detail_attributes,
        sales_details: sales_detail_attributes,
        id: '34b3fc86-483e-4112-8106-9b23d36f925c',
        code: 'Monster',
        description: 'Test description'
      )
    end

    let(:purchase_detail_attributes) do
      { unit_price: 100, account_code: '620', tax_type: 'NONE' }
    end

    let(:sales_detail_attributes) do
      { unit_price: 550, account_code: '200', tax_type: 'NONE' }
    end

    subject { item.to_xero_xml }

    it 'should include the purchase detail' do
      subject.should match(/PurchaseDetails/)
    end

    it 'should include the sales detail' do
      subject.should match(/SalesDetails/)
    end

    it 'should not include the id' do
      subject.should_not match(/ItemId/)
    end

    it 'should not include the id value' do
      subject.should_not match(/34b3fc86\-483e\-4112\-8106\-9b23d36f925c/)
    end

    it 'should include the code' do
      subject.should match(/Code/)
    end

    it 'should include the code value' do
      subject.should match(/Monster/)
    end

    it 'should include the unit price' do
      subject.should match(/UnitPrice/)
    end

    it 'should include the description' do
      subject.should match(/Description/)
    end

    it 'should include the description value' do
      subject.should match(/Test description/)
    end
  end

  describe '#purchase_details=' do

    let(:item) { Xero::Models::Item.new }

    before do
      item.purchase_details = {
        unit_price: 100, account_code: '620', tax_type: 'NONE'
      }
    end

    it 'should add a new item detail to the item' do
      item.purchase_details.should be_a(Xero::Models::ItemDetail)
    end

    it 'should set the unit price' do
      item.purchase_details.unit_price.should eql(100.0)
    end

    it 'should set the account code' do
      item.purchase_details.account_code.should eql('620')
    end

    it 'should set the tax type' do
      item.purchase_details.tax_type.should eql('NONE')
    end
  end

  describe '#sales_details=' do
    let(:item) { Xero::Models::Item.new }

    before do
      item.sales_details = {
        unit_price: 550, account_code: '200', tax_type: 'NONE'
      }
    end

    it 'should add a new item detail to the item' do
      item.sales_details.should be_a(Xero::Models::ItemDetail)
    end

    it 'should set the unit price' do
      item.sales_details.unit_price.should eql(550.0)
    end

    it 'should set the account code' do
      item.sales_details.account_code.should eql('200')
    end

    it 'should set the tax type' do
      item.sales_details.tax_type.should eql('NONE')
    end
  end
end
