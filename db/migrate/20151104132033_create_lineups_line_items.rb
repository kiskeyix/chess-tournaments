class CreateLineupsLineItems < ActiveRecord::Migration
  def change
    create_table :lineups_line_items do |t|
      t.integer :lineup_id
      t.integer :board_number
      t.integer :player_id
      t.boolean :rating_only
      t.boolean :alternate

      t.timestamps null: false
    end
  end
end
