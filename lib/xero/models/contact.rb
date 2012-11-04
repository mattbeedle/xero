module Xero
  module Models
    class Contact < Xero::Models::BaseModel

      self.path = 'Contacts'

      attribute :contact_number
      attribute :name
      attribute :first_name
      attribute :last_name
      attribute :contact_status
      attribute :skype_user_name
      attribute :bank_account_details
      attribute :tax_number
      attribute :accounts_receivable_tax_type
      attribute :accounts_payable_tax_type
      attribute :updated_date_utc, type: DateTime
      attribute :is_supplier, type: Boolean
      attribute :is_customer, type: Boolean
      attribute :default_currency
      attribute :email_address

      has_many :addresses
      has_many :phones

      validates :name, presence: true
    end
  end
end
