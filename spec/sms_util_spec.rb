require 'rails_helper'
require 'spec_helper'

require 'controller_helper'

describe SmsModule::SmsUtil do
 include ControllerHelper
  before(:all) do
    set_account
  end

  it 'should return appropriate boolean if in stop number list' do
    from_number = "123"
    to_number = "456"
    SmsModule::SmsUtil.add_numbers_to_stop_list(Account.current.id, from_number, to_number)
    expect(SmsModule::SmsUtil.is_number_in_stop_list(Account.current.id, from_number, to_number)).to eq true
    SmsModule::SmsUtil.remove_from_stop_list(Account.current.id, from_number, to_number)
    expect(SmsModule::SmsUtil.is_number_in_stop_list(Account.current.id, from_number, to_number)).to eq false
 end

end
