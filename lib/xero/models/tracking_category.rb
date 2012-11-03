module Xero
  module Models
    class TrackingCategory < Xero::Models::BaseModel

      self.path = 'TrackingCategories'

      attribute :name

      has_many :tracking_category_options
    end
  end
end
