require 'spec_helper'

describe Xero::Models::Phone do

  describe 'validations' do

    it { should validate_presence_of(:phone_type) }

    it { should validate_presence_of(:number) }

    it { should validate_presence_of(:area_code) }

    it { should validate_presence_of(:country_code) }
  end
end
