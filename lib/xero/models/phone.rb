module Xero
  module Models
    class Phone < BaseModel

      attribute :phone_type
      attribute :number
      attribute :area_code
      attribute :country_code

      validates :phone_type, presence: true
      validates :number, presence: true
      validates :area_code, presence: true
      validates :country_code, presence: true

      belongs_to :invoice
    end
  end
end
