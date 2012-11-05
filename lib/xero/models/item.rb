module Xero
  module Models
    class Item < BaseModel

      self.path = 'Items'

      attribute :code
      attribute :description
      attribute :updated_date_utc, type: DateTime

      validates :code, presence: true

      has_one :purchase_details, class_name: :item_detail
      has_one :sales_details, class_name: :item_detail

      has_many :line_items

      def to_xero_xml
        xero_attributes(attributes.clone).tap do |attrs|
          merge_purchase_details(attrs) unless purchase_details.blank?
          merge_sales_details(attrs) unless sales_details.blank?
        end.to_xml(root: 'Item')
      end

      private

      def merge_purchase_details(attrs)
        attrs.merge!(
          'PurchaseDetails' => self.purchase_details.xero_attributes
        )
      end

      def merge_sales_details(attrs)
        attrs.merge!('SalesDetails' => self.sales_details.xero_attributes)
      end
    end
  end
end
