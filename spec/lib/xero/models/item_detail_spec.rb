require 'spec_helper'

describe Xero::Models::ItemDetail do

  it { should validate_presence_of(:unit_price) }

  it { should validate_presence_of(:account_code) }

  it { should validate_presence_of(:tax_type) }
end
