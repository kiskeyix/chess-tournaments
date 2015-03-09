class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = current_user.messages.uniq
  end
  def show
    @message = Message.find params[:id]
  end
end
