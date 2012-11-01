module Xero
  module Models
    class ItemDetail < BaseModel

      attribute :unit_price, type: Float
      attribute :account_code
      attribute :tax_type

      validates :unit_price, presence: true
      validates :account_code, presence: true
      validates :tax_type, presence: true
    end
  end
end
