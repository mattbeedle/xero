module Xero
  class Configuration

    attr_accessor :logger, :consumer_key, :consumer_secret, :private_key_path,
      :invoice_due_days

    def initialize(options = {})
      default_options = { invoice_due_days: 30 }.merge(options)
      default_options.each { |key, value| self.send("#{key}=", value) }
      self
    end

    def logger
      @logger || Logger.new(STDOUT)
    end

    def xero_url
      'https://api.xero.com/api.xro/2.0'
    end
  end
end
