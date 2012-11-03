module Xero
  module Associations
    module HasMany
      extend ActiveSupport::Concern

      module ClassMethods
        def has_many(association_name, options = {})

          define_method association_name do
            var = instance_variable_get(:"@#{association_name}")
            if var.blank?
              var = HasManyProxy.new
              instance_variable_set(:"@#{association_name}", var)
            end
            var
          end

          define_method "#{association_name}=" do |value|
            if value.is_a?(Hash) && value[value.keys.first].is_a?(Array)
              klass = options[:class_name] || association_name.to_s.singularize
              klass = "Xero::Models::#{klass.to_s.classify}".constantize
              value[value.keys.first].each do |item|
                self.send(association_name).send :<<, klass.new(item)
              end
            end

            # if value.is_a?(Hash)
            #   klass = options[:class_name] || association_name.to_s.singularize
            #   value = "Xero::Models::#{klass.to_s.classify}".constantize.
            #     new(value)
            # end
            # instance_variable_set(
            #   :"@#{association_name}", HasManyProxy.new(value)
            # )
          end
        end
      end
    end
  end
end
