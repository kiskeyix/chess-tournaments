class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_signup_complete,
    only: [:new, :create, :update, :destroy]
  def ensure_signup_complete
    logger.debug "#{__method__}: #{controller_name}::#{action_name} #{params}"
    # avoid infinite loop
    return if action_name == 'finish_signup' ||
      (controller_name == "sessions" &&
       action_name == "destroy")
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
end
