module SmsModule

  module SmsUtil

    def self.is_stop_word?(sms_text)
      sms_text.strip.gsub(/\r\n/,"") == 'STOP'
    end

    STOP_NUMBER_EXPIRY = 14400

    def self.add_numbers_to_stop_list(account_id, from , to)
      key =  SmsModule::Constants::ACCOUNT_TEMP_STOP_NUMBERS % { account_id: account_id, from: from, to: to }
      $redis_client.setex(key, STOP_NUMBER_EXPIRY, "1")
    end

    def self.is_number_in_stop_list(account_id, from, to)
      key =  SmsModule::Constants::ACCOUNT_TEMP_STOP_NUMBERS % { account_id: account_id, from: from, to: to }
      $redis_client.exists(key) == true
    end

    def self.remove_from_stop_list(account_id, from , to)
      key =  SmsModule::Constants::ACCOUNT_TEMP_STOP_NUMBERS % { account_id: account_id, from: from, to: to }
      $redis_client.del(key)
    end


  end
end
