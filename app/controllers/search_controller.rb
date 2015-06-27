class SearchController < ApplicationController
  def index
    begin
      recipients = User.find_recipients params[:recipients]
      users = recipients.collect do |recipient|
        recipient.full_name
      end
    rescue => e
      logger.error "#{__METHOD__}: #{e.class} #{e.message}"
      users = nil
    end
    respond_to do |format|
      if users
        format.json { users }
      else
        format.json { head :no_content }
      end
    end
  end
end
