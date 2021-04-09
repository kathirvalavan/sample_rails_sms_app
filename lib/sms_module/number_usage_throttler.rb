module SmsModule
  class NumberUsageThrottler
    def initialize(number)
      @number  = number
    end

    def increment_usage
      identifier = get_identifier
      set_expiry = $redis_client.exists(identifier)
      $redis_client.incr(identifier)
      $redis_client.expire(identifier, throttle_duration) unless set_expiry
    end

    def is_limit_reached?
      get_current_limit >= throttle_limit
    end

    def throttle_duration
      86400
    end

    def throttle_limit
      50
    end

    def get_identifier
      "NumberUsageThrottler:#{Account.current.id}:#{@number}"
    end

    def get_current_limit
      identifier = get_identifier
      value = $redis_client.get(identifier)
      value.nil? ? 0 : value.to_i
    end


  end
end
