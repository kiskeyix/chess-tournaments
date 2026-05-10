class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  [:facebook, :github, :twitch, :google_oauth2].each do |provider|
    define_method(provider) do
      @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      logger.info "Sending user #{current_user} to #{resource} in super class"
      super resource
    else
      logger.info "User #{current_user} needs email (#{current_user.email})? #{resource}"
      finish_signup_path(resource)
    end
  end
end
