require 'rails_helper'
require 'spec_helper'

require 'controller_helper'

describe SmsController, type: :controller do

  include ControllerHelper

  before(:all) do
    set_account
  end



  it 'should throw invalid for from_number params ' do
    allow(controller).to receive(:authenticate_request).and_return(true)
    post :inbound_sms, params: { "from": "4924195509198", "to": "91983435345", "text": "hello" }
    expect(response.status).to eq 400
  end

  it 'should throw invalid for to_number params ' do
    allow(controller).to receive(:authenticate_request).and_return(true)
    post :inbound_sms, params: { "from": "4924", "to": "9198", "text": "hello" }
    expect(response.status).to eq 400
  end

  it 'should throw unauthorized if auth  headers not present ' do
    post :inbound_sms, params: { "from": "4924", "to": "9198", "text": "hello" }
    expect(response.status).to eq 403
  end

  it 'should authorize if auth headers present ' do
    request.headers.merge!({  'Authorization' => "Basic #{Base64.encode64("azr1:20S0KPNOIM")}" })
    post :inbound_sms, params: { "from": "91983435345", "to": "4924195509198", "text": "hello" }
    expect(response.status).to eq 200
  end


end
