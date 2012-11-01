require 'spec_helper'

describe Xero::Models::BaseModel do

  describe '#initialize' do
    let(:model) { Xero::Models::BaseModel.new }

    it 'should set new_record to true' do
      model.new_record.should be_true
    end
  end

  describe '#save' do
    context 'when client is blank' do
      let(:model) { Xero::Models::BaseModel.new }

      it 'should raise an error' do
        expect { model.save }.to raise_error
      end
    end
  end

  describe '#xero_attributes' do
    let(:model) do
      Xero::Models::BaseModel.new id: 'asdf'
    end


    it 'should not include the id' do
      model.xero_attributes['BaseModelId'].should be_blank
    end

    it 'should camelize the attributes' do
      model.xero_attributes(x_attr: 'something')['XAttr'].should eql('something')
    end
  end
end
