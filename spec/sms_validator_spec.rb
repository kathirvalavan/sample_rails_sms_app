require 'rails_helper'
require 'spec_helper'

require 'controller_helper'

describe SmsModule::SmsValidator do
 include ControllerHelper
  before(:all) do
    set_account
  end

  it 'should return appropriate boolean if in stop number list' do
    from_number = "123"
    to_number = "456"
    SmsModule::SmsUtil.add_numbers_to_stop_list(Account.current.id, from_number, to_number)
    expect(SmsModule::SmsValidator.new(from_number, to_number).can_send_sms?).to eq false
    SmsModule::SmsUtil.remove_from_stop_list(Account.current.id, from_number, to_number)
    expect(SmsModule::SmsValidator.new(from_number, to_number).can_send_sms?).to eq true
 end

end
