module Xero
  module Associations
    module BelongsTo
      extend ActiveSupport::Concern

      module ClassMethods
        def belongs_to(association_name, options = {})

          attr_accessor :"#{association_name}_id"

          define_method association_name do
            instance_variable_get(:"#{association_name}")
          end

          define_method "#{association_name}=" do |value|
            instance_variable_set(:"@#{association_name}", value)
            send "#{association_name}_id", value.id
          end
        end
      end
    end
  end
end
