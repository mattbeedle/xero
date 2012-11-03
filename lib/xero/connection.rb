module Xero
  class Connection

    attr_accessor :client, :consumer_options

    def initialize(options = {})
      self.consumer_options = {
        site: 'https://api.xero.com',
        request_token_path: '/oauth/RequestToken',
        access_token_path: '/oauth/AccessToken',
        authorize_path: '/oauth/Authorize'
      }.reverse_merge(options)
    end

    def consumer
      @consumer ||= ::OAuth::Consumer.new(
        Xero.configuration.consumer_key,
        Xero.configuration.consumer_secret,
        self.consumer_options
      )
    end

    def access_token
      @access_token ||= ::OAuth::AccessToken.new(
        consumer, Xero.configuration.consumer_key,
        Xero.configuration.consumer_secret
      )
    end

    def get_by_id(path, id)
      make_request(:get, "#{path}/#{id}")
    end

    def get(path, params = {})
      path = "#{path}?#{params.to_query}" unless params.blank?
      make_request(:get, path)
    end

    def post(path, payload, params = {})
      make_request(:post, path, { xml: payload })
    end

    private

    def make_request(method, path, params = {})
      uri = "#{Xero.configuration.xero_url}/#{path}"

      headers = { 'charset' => 'utf-8' }

      if method == :get
        response = access_token.get(uri, params)
      else
        response = access_token.post(uri, params, headers)
      end
      handle_response(response)
    end

    def handle_response(response)
      response
    end
  end
end
