class SmsController < ApplicationController

  before_action :validation_params_inbounds_sms, only: [:inbound_sms]
  before_action :validation_params_outbound_sms, only: [:outbound_sms]

  include SmsModule::SmsUtil

  def inbound_sms
    hash_params = params.permit!.to_h
    to_number = hash_params[:to]
    raise CustomErrors::DefaultError, { custom_message: "to parameter not found"} if PhoneNumber.where(number: to_number).blank?

    SmsModule::SmsUtil.add_numbers_to_stop_list(Account.current.id, hash_params[:from], hash_params[:to]) if SmsModule::SmsUtil.is_stop_word?(hash_params[:text])

    render json: { "message": "inbound sms ok", "error": "" }, status: 200
  end

  def outbound_sms
    hash_params = params.permit!.to_h
    from_number = hash_params[:from]
    to_number = hash_params[:to]

    raise CustomErrors::DefaultError, { custom_message: "to parameter not found"} if PhoneNumber.where(number: from_number).blank?

    unless SmsModule::SmsValidator.new(from_number, to_number).can_send_sms?
      raise CustomErrors::DefaultError, { custom_message: "sms from #{from_number} to #{to_number} blocked by STOP request"}
    end

    raise CustomErrors::DefaultError, { custom_message: "limit reached for from #{from_number}"} if SmsModule::NumberUsageThrottler.new(from_number).is_limit_reached?

    SmsModule::NumberUsageThrottler.new(from_number).increment_usage
    render json: { "message": "outbound sms ok", "error": "" }, status: 200
  end

  def validation_params_inbounds_sms
    validations = [
      { key_path: "from", type: DataValidator::STRING_TYPE, min_length: 6, max_length: 16, required: true },
      { key_path: "to", type: DataValidator::STRING_TYPE , min_length: 6, max_length: 120, required: true },
      { key_path: "text", type: DataValidator::STRING_TYPE, required: true }
    ]

    begin
      DataValidator.new(validations).validate(params.permit!.to_h)
    rescue CustomErrors::DataInvalidError => e
      render json: { "message": "", "error": e.message }, status: 403 and return
    end

  end

  def validation_params_outbound_sms
    validations = [
      { key_path: "from", type: DataValidator::STRING_TYPE, min_length: 6, max_length: 16, required: true },
      { key_path: "to", type: DataValidator::STRING_TYPE , min_length: 6, max_length: 120, required: true },
      { key_path: "text", type: DataValidator::STRING_TYPE, required: true, min_length: 1, max_length: 120 }
    ]

    begin
      DataValidator.new(validations).validate(params.permit!.to_h)
    rescue CustomErrors::DataInvalidError => e
      render json: { "message": "", "error": e.message }, status: 403 and return
    end
  end

end
