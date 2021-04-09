
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: proc { [403, {}, ["Not found."]] }
  post '/inbound/sms', to: 'sms#inbound_sms'
  post '/outbound/sms', to: 'sms#outbound_sms'

  match '/inbound/sms', to: 'home#method_not_found', via: [:get, :put]
  match '/outbound/sms', to: 'home#method_not_found', via: [:get, :put]

  match '*unmatched', to: 'home#not_found', via: [:get, :post, :put]

end
