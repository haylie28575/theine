module Access
  module MuchMeta

    def set_up_methods(values)
      self.class.class_eval do
        if Access.config.access_used_fields == 'true'
          attr_reader :used_fields
          values.keys.each do |key|
            define_method(key.to_sym) do
              @used_fields << key.to_sym
              instance_variable_get("@#{key.to_sym}")
            end
          end
        else
          attr_reader(*values.keys)
        end
      end
    end

    def set_values(values)
      values.each do |attribute_name, attribute_value|
        self.instance_variable_set("@#{attribute_name}", attribute_value)
      end
    end

  end
end
