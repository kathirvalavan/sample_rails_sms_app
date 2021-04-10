require 'rails_helper'
require 'spec_helper'

require 'controller_helper'

describe SmsModule::NumberUsageThrottler do
 include ControllerHelper
  before(:all) do
    set_account
  end

  it 'should return false is_limit_reached? if number is not used yet' do
    expect(SmsModule::NumberUsageThrottler.new("1234").is_limit_reached?).to eq false
  end

  it 'should return true is_limit_reached? if number limit is exceeded' do
    number = "12345"
    SmsModule::NumberUsageThrottler.new(number).clear_usage
    allow_any_instance_of(SmsModule::NumberUsageThrottler).to receive(:throttle_limit).and_return(2)
    2.times do
      SmsModule::NumberUsageThrottler.new(number).increment_usage
    end

    expect(SmsModule::NumberUsageThrottler.new(number).is_limit_reached?).to eq true
  end

  it 'should return current usage limit' do
    number = "12345"
    SmsModule::NumberUsageThrottler.new(number).clear_usage

    4.times do
      SmsModule::NumberUsageThrottler.new(number).increment_usage
    end

    expect(SmsModule::NumberUsageThrottler.new(number).get_current_limit).to eq 4
  end

end
