module Helpers
  def configure
    Xero.configure do |config|
      config.consumer_key     = 'TYMATGTPO5QEAWP8I307AOMBHSOJI2'
      config.consumer_secret  = 'VWZPP3PBRGERW7UFSULKZMBRZDRXIM'
      config.private_key_path = 'spec/support/privatekey.pem'
    end
  end
end
