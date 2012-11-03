module Xero
  module Models
    class BaseModel
      include ActiveAttr::Model
      include Xero::Associations

      class << self
        attr_accessor :path
      end

      attribute :id

      attr_accessor :new_record, :client

      def initialize(attributes = {})
        @new_record = true
        cleanup_hash(attributes).each { |key, value| send("#{key}=", value) }
      end

      def save
        raise StandardError if self.client.blank?
        self.client.save(self)
      end

      def xero_attributes(attrs = nil)
        attrs ||= attributes.clone
        attrs.delete('id')
        attrs.keys.each do |key|
          value = attrs.delete(key)
          value = xero_attributes(value) if value.is_a?(Hash)
          attrs[key.to_s.camelize] = value.to_s
        end
        attrs
      end

      def cleanup_hash(hash)
        hash.keys.each do |key|
          value = hash.delete(key)
          value = cleanup_hash(value) if value.is_a?(Hash)
          key = key.to_s.underscore
          key = 'id' if key.match(/_id/)
          hash[key] = value
        end
        hash
      end

      def persisted?
        id && !@new_record
      end
    end
  end
end
