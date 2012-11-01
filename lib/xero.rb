require 'active_attr'
require 'active_support/core_ext'
require 'oauth'
require 'xero/client'
require 'xero/clients/partner_application'
require 'xero/clients/private_application'
require 'xero/configuration'
require 'xero/connection'
require 'xero/models/base_model'
require 'xero/models/account'
require 'xero/models/item'
require 'xero/models/item_detail'
require "xero/version"

module Xero
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration = Xero::Configuration.new
    yield(configuration)
    return self.configuration
  end
end
