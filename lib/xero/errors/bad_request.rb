module Xero
  module Errors
    class BadRequest < StandardError

      attr_reader :request_xml, :response_xml, :type, :message

      def initialize(request_xml, response_xml)
        @request_xml = request_xml
        @response_xml = response_xml
        Hash.from_xml(response_xml).tap do |data|
          @type = data[:Type]
          @message = data[:Message]
          @error_number = data[:ErrorNumber]
        end
        self
      end

      def message
        "#{@type}: #{@message}"
      end
    end
  end
end
