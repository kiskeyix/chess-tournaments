class AddLeagueIdToTournament < ActiveRecord::Migration[4.2]
  def change
    add_column :tournaments, :league_id, :integer
  end
end
