module Xero
  module Models
    class LineItem < Xero::Models::BaseModel

      attribute :description
      attribute :quantity, type: Float
      attribute :unit_amount, type: Float
      attribute :account_code

      validates :description, presence: true
      validates :quantity, presence: true
      validates :unit_amount, presence: true
      validates :account_code, presence: true
    end
  end
end
