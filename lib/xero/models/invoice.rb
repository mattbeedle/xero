module Xero
  module Models
    class Invoice < Xero::Models::BaseModel

      self.path = 'Invoices'

      TYPES = ['ACCPAY', 'ACCREC']

      attribute :type
      attribute :date, type: Date
      attribute :due_date, type: Date
      attribute :line_amount_type
      attribute :invoice_number
      attribute :reference
      attribute :url
      attribute :currency_code
      attribute :status
      attribute :line_amount_types
      attribute :subtotal, type: Float
      attribute :total_tax, type: Float
      attribute :total, type: Float
      attribute :amount_due, type: Float
      attribute :amount_paid, type: Float
      attribute :amount_credited, type: Float
      attribute :total_discount, type: Float
      attribute :sub_total
      attribute :updated_date_utc, type: DateTime
      attribute :has_attachments, type: Boolean
      attribute :sent_to_contact, type: Boolean
      attribute :currency_rate

      has_one  :contact
      has_many :line_items
      has_many :payments

      validates :type, presence: true
      validates :contact, presence: true
      validates :line_items, presence: true

      def to_xero_xml
        xero_attributes(attributes.clone).
          merge('Contact' => contact.xero_attributes).
          merge('LineItems' => line_items.xero_attributes).
          merge('Payments' => payments.xero_attributes).
          to_xml(root: 'Invoice')
      end

    end
  end
end
