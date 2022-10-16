class ApplicationController < ActionController::API
  before_action :configure_sign_up_params, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :password])
  end
end
