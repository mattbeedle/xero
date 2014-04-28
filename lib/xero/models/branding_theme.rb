module Xero
  module Models
    class BrandingTheme < Xero::Models::BaseModel
      self.path = 'BrandingThemes'

      attribute :name
      attribute :sort_order, type: Integer
      attribute :created_date_utc, type: DateTime
    end
  end
end
