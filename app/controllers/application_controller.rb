class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :profile_picture, address: [:street_address, :city, :state, :zip_code, :phone_number]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      users_path
    else
      edit_user_path(resource)
    end
  end
end
