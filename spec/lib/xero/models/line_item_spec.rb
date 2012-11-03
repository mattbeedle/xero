require 'spec_helper'

describe Xero::Models::LineItem do

  it { should validate_presence_of(:description) }

  it { should validate_presence_of(:quantity) }

  it { should validate_presence_of(:unit_amount) }

  it { should validate_presence_of(:account_code) }
end
