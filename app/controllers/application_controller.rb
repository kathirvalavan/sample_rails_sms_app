class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request

  rescue_from CustomErrors::AuthenticationFailed, with: :render_nothing_error
  rescue_from CustomErrors::DefaultError, with: :render_default_error

   def authenticate_request
     Account.reset_current
     begin
       header_value = request.headers['Authorization']
       creds = ::Base64.decode64(request.authorization.split(' ', 2).last || '')
       uname, pwd = creds.split(':')
       account = Account.where(username: uname, auth_id: pwd).first
       raise CustomErrors::AuthenticationFailed if account.blank?
       account.set_current
     end
   end

  def render_nothing_error
    render plain: "Not found", status: 403 and return
  end

  def render_default_error(e)
    render json: { "message": "", "error": e.message }, status: 400 and return
  end

end
