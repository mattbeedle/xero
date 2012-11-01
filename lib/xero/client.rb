module Xero
  class Client

    attr_accessor :client

    def initialize(options = {})
      self.client = OAuth::Consumer.new(
        Xero.configuration.consumer_key,
        Xero.configuration.consumer_secret, options
      )
    end

    def get_item(item_id)
      response = self.connection.get_by_id(Xero::Models::Item.path, item_id)
      item = cleanup_response(response, 'Items', 'Item')
      Xero::Models::Item.new(item)
    end

    def items(options = {})
      response = self.connection.get(Xero::Models::Item.path, options)
      items = cleanup_response(response, 'Items', 'Item')

      items.map { |item| Xero::Models::Item.new(item) }
    end

    def save(model)
      model.tap do |item|
        response = self.connection.post(model.class.path, model.to_xero_xml)
        attrs = Hash.from_xml(response.body)['Response']['Items']['Item']
        model.id = attrs["#{model.class.to_s.demodulize}ID"]
        model.new_record = false
      end
    end

    def build_item(attributes = {})
      build_model Xero::Models::Item, attributes
    end

    def build_model(klass, item_attributes = {})
      klass.new(item_attributes).tap do |item|
        item.client = self
      end
    end

    protected

    def connection
      @connection ||= Xero::Connection.new
    end

    def cleanup_response(response, plural, singular)
      items = Hash.from_xml(response.body)['Response'][plural][singular]
      if items.is_a?(Array)
        items.each { |item| cleanup_hash(item) }
      else
        cleanup_hash(items)
      end
      items
    end

    def cleanup_hash(hash)
      hash.keys.each do |key|
        value = hash.delete(key)
        value = cleanup_hash(value) if value.is_a?(Hash)
        key = key.underscore.singularize
        key = 'id' if key.match(/_id/)
        hash[key] = value
      end
      hash
    end
  end
end
