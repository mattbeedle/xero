module Xero
  module Models
    class Address < BaseModel

      attribute :address_type
      attribute :attention_to
      attribute :address_line1
      attribute :address_line2
      attribute :address_line3
      attribute :address_line4
      attribute :city
      attribute :region
      attribute :postal_code
      attribute :country

      validates :address_type, presence: true
      validates :attention_to, presence: true
      validates :address_line1, presence: true
      validates :city, presence: true
      validates :region, presence: true
      validates :postal_code, presence: true
      validates :country, presence: true

      belongs_to :contact
      belongs_to :phone
    end
  end
end
