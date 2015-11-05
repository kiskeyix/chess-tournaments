class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :board_number
      t.integer :player_id
      t.boolean :rating_only
      t.boolean :alternate

      t.timestamps null: false
    end
  end
end
