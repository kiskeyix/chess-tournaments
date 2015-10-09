class SearchController < ApplicationController
  before_action :authenticate_user!
  def index
    if params.key? 'recipients'
      begin
        recipients = User.find_recipients params['recipients']
        users = recipients.collect do |recipient|
          recipient.full_name
        end
      rescue => e
        logger.error "#{__method__}: #{e.class} #{e.message}"
        users = nil
      end
      respond_to do |format|
        if users
          format.json { users }
        else
          format.json { head :no_content }
        end
      end
    elsif params.key? 'q' and params['q'] > ''
      @results = []
      @results << Team.where('name LIKE ?', "%#{params['q']}%")
      @results << Tournament.where('name LIKE ?', "%#{params['q']}%")
      @results << Player.where('name LIKE ?', "%#{params['q']}%")
      @results.flatten!
      if @results.size == 1
        result = @results.first
        # aren't you lucky?
        redirect_to controller: result.class.to_s.downcase.pluralize,
          action: 'show', id: result.id, q: params['q']
        return
      end
    else
      @results = []
    end
  end
end
