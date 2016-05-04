class CreateGamesLineupsLineItemsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :games, :lineups_line_items do |t|
      # t.index [:game_id, :lineups_line_item_id]
      # t.index [:lineups_line_item_id, :game_id]
    end
  end
end
