class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = current_user.messages.uniq
  end
  def show
    @message = Message.find params[:id]
    unless @message.user == current_user or @message.users.include? current_user
      flash[:alert] = "You cannot see this message since it's not addressed to you or written by you!"
      redirect_to dashboard_path
    end
  end
end
