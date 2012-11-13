module Xero
  module Errors
    class BadRequest < StandardError

      attr_reader :request_xml, :response_xml, :type, :message

      def initialize(request_xml, response_xml)
        @request_xml = request_xml
        @response_xml = response_xml
        Hash.from_xml(response_xml).tap do |data|
          @type = data['ApiException']['Type']
          @message = data['ApiException']['Message']
          @error_number = data['ApiException']['ErrorNumber']
        end
        self
      end

      def message
        "#{@type}: #{@message}"
      end
    end
  end
end
