module Xero
  module Models
    class Invoice < Xero::Models::BaseModel

      self.path = 'Invoices'

      TYPES = ['ACCPAY', 'ACCREC']

      attribute :type
      attribute :date, type: Date
      attribute :due_date, type: Date, default:
        lambda { Date.parse(Xero.configuration.invoice_due_days.days.from_now.to_s).to_s }
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
      attribute :branding_theme_id

      has_one  :contact
      has_many :line_items
      has_many :payments

      validates :type, presence: true
      validates :contact, presence: true
      validates :line_items, presence: true

      def to_xero_xml
        xero_attributes(attributes.clone).tap do |attrs|
          merge_contact(attrs) unless contact.blank?
          merge_line_items(attrs) unless line_items.blank?
          merge_payments(attrs) unless payments.blank?
        end.to_xml(root: 'Invoice')
      end

      private

      def merge_contact(attrs)
        attrs.merge!('Contact' => contact.xero_attributes)
      end

      def merge_line_items(attrs)
        attrs.merge!('LineItems' => line_items.xero_attributes)
      end

      def merge_payments(attrs)
        attrs.merge!('Payments' => payments.xero_attributes)
      end
    end
  end
end
