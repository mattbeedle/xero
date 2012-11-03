module Xero
  module Associations
    module HasOne
      extend ActiveSupport::Concern

      module ClassMethods
        def has_one(association_name, options = {})

          define_method association_name do
            instance_variable_get(:"@#{association_name}")
          end

          define_method "#{association_name}=" do |value|
            if value.is_a?(Hash)
              klass = options[:class_name] || association_name
              value = "Xero::Models::#{klass.to_s.classify}".constantize.
                new(value)
            end
            instance_variable_set(:"@#{association_name}", value)
          end
        end
      end
    end
  end
end
