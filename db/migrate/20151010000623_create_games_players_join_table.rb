class CreateGamesPlayersJoinTable < ActiveRecord::Migration[4.2]
  def change
    create_join_table :games, :players do |t|
      t.index [:game_id, :player_id]
      t.index [:player_id, :game_id]
    end
  end
end
