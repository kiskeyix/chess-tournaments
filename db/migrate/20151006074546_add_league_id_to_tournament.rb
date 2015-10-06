class AddLeagueIdToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :league_id, :integer
  end
end
