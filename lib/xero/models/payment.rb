module Xero
  module Models
    class Payment < Xero::Models::BaseModel

      self.path = 'Payments'

      attribute :date, type: Date
      attribute :currency_rate, type: Float
      attribute :amount, type: Float
      attribute :reference

      belongs_to :invoice
      belongs_to :account

      validates :amount, presence: true
      validates :date, presence: true
      validates :invoice, presence: true
      validates :account, presence: true
    end
  end
end
