module SmsModule
  class SmsValidator
    def initialize(from, to)
      @from = from
      @to   = to
    end

    def can_send_sms?
      if SmsModule::SmsUtil.is_number_in_stop_list(Account.current.id, @from, @to) || SmsModule::SmsUtil.is_number_in_stop_list(Account.current.id, @to, @from)
        return false
      end
      return true
    end

  end
end
