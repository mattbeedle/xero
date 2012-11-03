module Xero
  module Models
    class TrackingCategoryOption < Xero::Models::BaseModel

      attribute :name

      validates :name, presence: true

      belongs_to :tracking_category
    end
  end
end
