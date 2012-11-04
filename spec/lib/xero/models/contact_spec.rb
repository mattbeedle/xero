require 'spec_helper'

describe Xero::Models::Contact do

  it { should validate_presence_of(:name) }
end
