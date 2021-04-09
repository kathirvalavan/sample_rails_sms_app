module CustomErrors
  class AuthenticationFailed < StandardError
  end

  class DataInvalidError < StandardError
    attr_accessor :options
    def initialize(options = {})
      @options = options
    end

    def message
      case options[:failed_validation]
      when :required
        "#{options[:key_path]} is missing"
      when :min_length
        "#{options[:key_path]} is invalid"
      when :max_length
        "#{options[:key_path]} is invalid"
      end
    end
  end

  class DefaultError < StandardError
    attr_accessor :options
    def initialize(options = {})
      @options = options
    end

    def message
      @options[:custom_message] || "Error has occured"
    end
  end

end
