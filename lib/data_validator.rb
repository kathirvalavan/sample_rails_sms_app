
class DataValidator

  STRING_TYPE = 'string'

  attr_accessor :validation_rules

  def initialize(validation_rules = [])
    @validation_rules = validation_rules
  end

  def validate(data = {})
    @validation_rules.each do |rule|
      value = get_key_path_value(rule[:key_path], data)
      if rule[:required] == true
        raise CustomErrors::DataInvalidError, { key_path: rule[:key_path], failed_validation: :required } unless is_valid?(value)
      end


      if rule[:type] == "string"
        raise CustomErrors::DataInvalidError, { key_path: rule[:key_path], failed_validation: :type }  unless value.is_a?(String)

        if rule[:min_length] && rule[:min_length] >= 0
          raise CustomErrors::DataInvalidError, { key_path: rule[:key_path], failed_validation: :min_length } if value.length < rule[:min_length]
        end

        if rule[:max_length] && rule[:max_length] >= 0
          raise CustomErrors::DataInvalidError, { key_path: rule[:key_path], failed_validation: :max_length } if value.length > rule[:max_length]
        end
      end
    end
    return true
  end

  def is_valid?(value)
    return false if value.blank?
    return true
  end

  def get_key_path_value(key_path, value_container)
    begin
      value_container[key_path]
    rescue Exception =>e
      nil
    end
  end
end
