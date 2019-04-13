module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def rules
      @rules ||= []
    end

    def validate(var_name, validation_type, option = nil)
      rules << { var_name: var_name,
                  validation_type: validation_type.to_sym,
                  option: option }
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue RuntimeError
      false
    end

    def validate!
      self.class.rules.each do |rule|
        var_value = instance_variable_get("@#{rule[:var_name]}")
        send rule[:validation_type], var_value, rule[:option]
      end
    end

    def presence(var_value, _option)
      if var_value.nil? || var_value.empty?
        raise "Parameter can`t be nil or empty(for String class)"
      end
    end

    def validate_type(var_value, option)
      raise "Parameter has wrong type" unless var_value.is_a?(option)
    end

    def validate_format(var_value, option)
      raise "Parameter has wrong format" if var_value !~ option
    end
  end
end
