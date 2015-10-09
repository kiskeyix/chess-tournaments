class DashboardController < ApplicationController
  def index
    if user_signed_in? and current_user.player
      @teams = current_user.player.teams.paginate(page: params[:page], per_page: 15)
      @open_tournaments = current_user.player.open_tournaments.paginate(page: params[:otpage], per_page: 15)
      @past_tournaments = current_user.player.past_tournaments.paginate(page: params[:ptpage], per_page: 15)
    else
      @teams = []
      @open_tournaments = []
      @past_tournaments = []
    end
  end
end
