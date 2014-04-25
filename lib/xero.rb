require 'active_attr'
require 'active_support/core_ext'
require 'active_support/inflection_config'
require 'oauth'
require 'xero/associations/belongs_to'
require 'xero/associations/has_many'
require 'xero/associations/has_many_proxy'
require 'xero/associations/has_one'
require 'xero/associations'
require 'xero/client'
require 'xero/clients/partner_application'
require 'xero/clients/private_application'
require 'xero/configuration'
require 'xero/connection'
require 'xero/errors/bad_request'
require 'xero/models/base_model'
require 'xero/models/account'
require 'xero/models/address'
require 'xero/models/branding_theme'
require 'xero/models/contact'
require 'xero/models/invoice'
require 'xero/models/item'
require 'xero/models/item_detail'
require 'xero/models/line_item'
require 'xero/models/payment'
require 'xero/models/phone'
require 'xero/models/tracking_category'
require 'xero/models/tracking_category_option'
require 'xero/version'

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
