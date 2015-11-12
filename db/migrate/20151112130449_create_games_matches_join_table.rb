class CreateGamesMatchesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :games, :matches do |t|
      t.index [:game_id, :match_id]
      t.index [:match_id, :game_id]
    end
  end
end
