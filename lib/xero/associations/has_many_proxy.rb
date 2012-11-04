module Xero
  module Associations
    class HasManyProxy < BasicObject

      def initialize(*args)
        @target = ::Array.new(*args)
      end

      def xero_attributes
        target.map(&:xero_attributes)
      end

      protected

      def target
        @target
      end

      def method_missing(method, *args, &block)
        target.send method, *args, &block
      end
    end
  end
end
