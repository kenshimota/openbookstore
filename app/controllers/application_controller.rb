class ApplicationController < ActionController::API
  before_action :configure_sign_up_params, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken

  def params_search
    data = { limit: 10, offset: 0, search: '' }

    if params[:page_size] and params[:page_size].to_i > 0 and params[:page_size].to_i < 100
      data[:limit] = params[:page_size].to_i
    end

    if params[:page] and params[:page].to_i > 1
      data[:offset] = (params[:page].to_i - 1) * data[:limit]
    end

    if params[:search]
      data[:search] = params[:search]
    end

    data
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :password])
  end
end
