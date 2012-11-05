module Helpers
  def configure
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO

    Xero.configure do |config|
      config.consumer_key     = 'TYMATGTPO5QEAWP8I307AOMBHSOJI2'
      config.consumer_secret  = 'VWZPP3PBRGERW7UFSULKZMBRZDRXIM'
      config.private_key_path = 'spec/support/privatekey.pem'
      config.logger           = logger
    end
  end
end
