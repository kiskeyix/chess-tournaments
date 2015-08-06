class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    logger.debug "#{__method__}: #{params}"
    # authorize! :update, @user
    if request.patch? && params[:user] && params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to dashboard_path, notice: 'Your profile was successfully updated.'
      else
        begin
          providers = User.find_by_email(params[:user][:email]).identities.collect(&:provider).join(', ').titleize
        rescue => e
          logger.debug "#{__method__}: caught error #{e.class} when searching #{params}. #{e.message}"
          providers = []
        end
        current_user.errors[:base] << "Could not update E-Mail. Make sure that you're not already registered with this E-Mail address (#{providers.size > 0 ? providers.first : "local"} maybe?).\n\nSend email to #{CHESS_ADMIN_EMAIL} to have us associate this email with the provider you chose. Be sure to include: Your name, your email address, providers."
        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    #@user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  # POST /users/delete_identity
  def delete_identity
    unless current_user.identities.size > 1
      current_user.errors[:base] << "Only 1 identity provider left."
      respond_to do |format|
        format.html { redirect_to :back, alert: 'Only 1 identity provider left.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      return
    end
    user_identity = current_user.identities.find params[:id]
    respond_to do |format|
      if user_identity and user_identity.destroy
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, alert: 'Could not disconnect provider' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users/link_player
  def link_player
    @user = User.find(user_params[:id])
    @player = Player.find(user_params[:player_id])
    @user.player = @player
    respond_to do |format|
      if @user.save
        format.html { redirect_to :back, notice: "User linked with player" }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, alert: 'Could not disconnect provider' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = [ :username, :name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    accessible << [ :player_id, :id ] if current_user.admin?
    params.require(:user).permit(accessible)
  end
end
