module Xero
  module Models
    class LineItem < Xero::Models::BaseModel

      attribute :description
      attribute :quantity, type: Float
      attribute :unit_amount, type: Float
      attribute :account_code

      validates :description, presence: true, unless: :item
      validates :quantity, presence: true
      validates :unit_amount, presence: true, unless: :item
      validates :account_code, presence: true, unless: :item

      belongs_to :invoice
      belongs_to :item

      def xero_attributes(attrs = nil)
        attrs = super(attrs)
        attrs.merge!('ItemCode' => item.code) if item
        attrs
      end
    end
  end
end
