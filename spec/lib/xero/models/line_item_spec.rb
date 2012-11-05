require 'spec_helper'

describe Xero::Models::LineItem do

  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:quantity) }

  it { should validate_presence_of(:unit_amount) }

  it { should validate_presence_of(:account_code) }

  context 'when item is set' do
    let(:line_item) do
      Xero::Models::LineItem.new(item: Xero::Models::Item.new)
    end

    it 'should not require description' do
      line_item.should_not validate_presence_of(:description)
    end

    it 'should not require unit amount' do
      line_item.should_not validate_presence_of(:unit_amount)
    end

    it 'should not require account code' do
      line_item.should_not validate_presence_of(:account_code)
    end
  end
end
