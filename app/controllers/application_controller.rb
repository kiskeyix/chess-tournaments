class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_signup_complete
    
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def ensure_signup_complete
    logger.debug "#{__method__}: called to #{controller_name}::#{action_name} #{params}"
    # avoid infinite loop
    return if action_name == 'finish_signup' ||
      (controller_name == "devise/sessions" &&
       action_name =~ /destroy|new|create/) ||
      (controller_name == "registrations" &&
       action_name == "create") ||
      (controller_name == "confirmations" &&
       action_name == "show")

    logger.debug "#{__method__}: email verified yet? #{controller_name}::#{action_name} #{params}"
    if current_user && !current_user.email_verified?
      logger.debug "#{__method__}: email not verified. Redirecting to #{finish_signup_path(current_user)}"
      redirect_to finish_signup_path(current_user), notice: 'Your email is not verified yet. Be sure to check your emails and click on the verification link.'
    end
  end
  def configure_permitted_parameters
    extra_params = [ :email,
                     :image, :firstname, :lastname,
                     :middlename, :surname, :gender, :birthday ]
    devise_parameter_sanitizer.for(:sign_up) << extra_params
    devise_parameter_sanitizer.for(:account_update) << extra_params
  end
end
