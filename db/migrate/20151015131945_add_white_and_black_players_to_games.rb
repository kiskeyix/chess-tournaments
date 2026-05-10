class AddWhiteAndBlackPlayersToGames < ActiveRecord::Migration[4.2]
  def change
    add_column :games, :white_player_id, :integer
    add_column :games, :black_player_id, :integer
  end
end
