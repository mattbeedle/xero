module Xero
  module Models
    class Item < BaseModel

      self.path = 'Items'

      attr_accessor :purchase_detail, :sales_detail

      attribute :code
      attribute :description

      validates :code, presence: true
      validates :purchase_detail, presence: true
      validates :sales_detail, presence: true

      def purchase_detail=(detail)
        detail = ItemDetail.new(detail) if detail.is_a?(Hash)
        @purchase_detail = detail
      end

      def sales_detail=(detail)
        detail = ItemDetail.new(detail) if detail.is_a?(Hash)
        @sales_detail = detail
      end

      def to_xero_xml
        xero_attributes(attributes.clone).
          merge('PurchaseDetails' => self.purchase_detail.xero_attributes).
          merge('SalesDetails' => self.sales_detail.xero_attributes).
          to_xml(root: 'Item')
      end
    end
  end
end
