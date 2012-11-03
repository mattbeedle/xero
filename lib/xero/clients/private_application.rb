module Xero
  module Clients
    class PrivateApplication < Client
      def connection
        @connection ||= Xero::Connection.new(
          signature_method: 'RSA-SHA1',
          private_key_file: Xero.configuration.private_key_path
        )
      end
    end
  end
end
