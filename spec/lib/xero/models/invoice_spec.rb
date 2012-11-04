require 'spec_helper'

describe Xero::Models::Invoice do

  it { should validate_presence_of(:type) }

  it { should validate_presence_of(:contact) }

  it { should validate_presence_of(:line_items) }
end
