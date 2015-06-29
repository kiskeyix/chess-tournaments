class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # TODO ensure user has validated email before proceeding? add :show below
  before_filter :ensure_signup_complete,
    only: [:new, :create, :update, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def ensure_signup_complete
    logger.debug "#{__method__}: #{controller_name}::#{action_name} #{params}"
    # avoid infinite loop
    return if action_name == 'finish_signup' ||
      (controller_name == "sessions" &&
       action_name == "destroy") ||
      (controller_name == "registrations" &&
       action_name == "create")
    if current_user && !current_user.email_verified?
      logger.debug "#{__method__}: redirecting to #{finish_signup_path(current_user)}"
      redirect_to finish_signup_path(current_user)
    end
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :email
  end
end
