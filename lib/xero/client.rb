module Xero
  class Client
    attr_accessor :client

    def initialize(options = {})
      self.client = OAuth::Consumer.new(
        Xero.configuration.consumer_key,
        Xero.configuration.consumer_secret, options
      )
    end

    def contacts(options = {})
      response = self.connection.get(Xero::Models::Contact.path, options)
      contacts_attributes = hash_from_response(response, 'Contacts')
      unless contacts_attributes.is_a?(Array)
        contacts_attributes = [contacts_attributes]
      end
      contacts_attributes.map { |attrs| Xero::Models::Contact.new(attrs) }
    end

    def get_contact(contact_id)
      response = self.connection.
        get_by_id(Xero::Models::Contact.path, contact_id)
      Xero::Models::Contact.new hash_from_response(response, 'Contacts')
    end

    def get_item(item_id)
      response = self.connection.get_by_id(Xero::Models::Item.path, item_id)
      Xero::Models::Item.new(hash_from_response(response, 'Items'))
    end

    def items(options = {})
      response = self.connection.get(Xero::Models::Item.path, options)
      items = hash_from_response(response, 'Items')
      items.map { |item| Xero::Models::Item.new(item) }
    end

    def get_invoice(invoice_id)
      response = self.connection.
        get_by_id(Xero::Models::Invoice.path, invoice_id)
      Xero::Models::Invoice.new hash_from_response(response, 'Invoices')
    end

    def invoices(options = {})
      response = self.connection.get(Xero::Models::Invoice.path, options)
      invoices_attributes = hash_from_response(response, 'Invoices')
      unless invoices_attributes.is_a?(Array)
        invoices_attributes = [invoices_attributes]
      end
      invoices_attributes.map { |attrs| Xero::Models::Invoice.new(attrs) }
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

    def hash_from_response(response, klass_name)
      attributes = Hash.from_xml(response.body)['Response']
      attributes[klass_name][klass_name.singularize]
    end
  end
end
