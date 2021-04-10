require 'rails_helper'
require 'spec_helper'

require 'controller_helper'

describe DataValidator do

  it 'should throw required validation if params not present' do

    validations = [
      { key_path: "from", type: DataValidator::STRING_TYPE, min_length: 1, max_length: 16, required: true },
      { key_path: "to", type: DataValidator::STRING_TYPE , min_length: 6, max_length: 120, required: true },
    ]
    data_hash = { "from" => "123" }

    failed = false
    failed_message = ''

    begin
      DataValidator.new(validations).validate(data_hash)
    rescue CustomErrors::DataInvalidError => e
      failed = true
      failed_message = e.message
    end

    expect(failed).to eq true
    expect(failed_message).to eq "to is missing"
  end

  it 'should throw min length validation if length is lesser' do
    validations = [
      { key_path: "from", type: DataValidator::STRING_TYPE, min_length: 3, max_length: 16, required: true },
      { key_path: "to", type: DataValidator::STRING_TYPE , min_length: 3, max_length: 120, required: true },
    ]
    data_hash = { "from" => "12", "to" => "23" }

    failed = false
    failed_message = ''

    begin
      DataValidator.new(validations).validate(data_hash)
    rescue CustomErrors::DataInvalidError => e
      failed = true
      failed_message = e.message
    end

    expect(failed).to eq true
    expect(failed_message).to eq "from is invalid"
  end

  it 'should throw max length validation if length is greater' do
    validations = [
      { key_path: "from", type: DataValidator::STRING_TYPE, min_length: 3, max_length: 4, required: true },
      { key_path: "to", type: DataValidator::STRING_TYPE , min_length: 3, max_length: 120, required: true },
    ]
    data_hash = { "from" => "12345", "to" => "233" }

    failed = false
    failed_message = ''

    begin
      DataValidator.new(validations).validate(data_hash)
    rescue CustomErrors::DataInvalidError => e
      failed = true
      failed_message = e.message
    end

    expect(failed).to eq true
    expect(failed_message).to eq "from is invalid"
  end

  it 'should not throw error for valid data' do
    validations = [
      { key_path: "from", type: DataValidator::STRING_TYPE, min_length: 3, max_length: 6, required: true },
      { key_path: "to", type: DataValidator::STRING_TYPE , min_length: 3, max_length: 120, required: true },
    ]
    data_hash = { "from" => "12345", "to" => "2334" }

    failed = false
    failed_message = ''

    begin
      DataValidator.new(validations).validate(data_hash)
    rescue CustomErrors::DataInvalidError => e
      failed = true
      failed_message = e.message
    end

    expect(failed).to eq false
  end

end
