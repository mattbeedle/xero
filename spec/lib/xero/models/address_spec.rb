require 'spec_helper'

describe Xero::Models::Address do

  describe 'validations' do

    it { should validate_presence_of(:address_type) }

    it { should validate_presence_of(:attention_to) }

    it { should validate_presence_of(:address_line1) }

    it { should validate_presence_of(:city) }

    it { should validate_presence_of(:region) }

    it { should validate_presence_of(:postal_code) }

    it { should validate_presence_of(:country) }
  end
end
