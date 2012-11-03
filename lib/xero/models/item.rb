module Xero
  module Models
    class Item < BaseModel

      self.path = 'Items'

      attribute :code
      attribute :description
      attribute :updated_date_utc, type: DateTime

      validates :code, presence: true
      validates :purchase_details, presence: true
      validates :sales_details, presence: true

      has_one :purchase_details, class_name: :item_detail
      has_one :sales_details, class_name: :item_detail

      def to_xero_xml
        xero_attributes(attributes.clone).
          merge('PurchaseDetails' => self.purchase_details.xero_attributes).
          merge('SalesDetails' => self.sales_details.xero_attributes).
          to_xml(root: 'Item')
      end
    end
  end
end
