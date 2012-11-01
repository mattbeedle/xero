module Xero
  class Configuration

    attr_accessor :logger, :consumer_key, :consumer_secret, :private_key_path

    def logger
      @logger || Logger.new(STDOUT)
    end

    def xero_url
      'https://api.xero.com/api.xro/2.0'
    end
  end
end
