require 'spec_helper'

describe Xero::Models::Invoice do

  it { should validate_presence_of(:type) }
end
