class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :name
      t.text :description
      t.integer :round_id
      t.text :location
      t.integer :home_team_id
      t.integer :home_team_lineup_id
      t.integer :guest_team_id
      t.integer :guest_team_lineup_id
      t.datetime :postponed_date
      t.integer :result_id

      t.timestamps null: false
    end
    add_index :matches, :name
    add_index :matches, :round_id
    add_index :matches, :home_team_id
    add_index :matches, :guest_team_id
    add_index :matches, :guest_team_lineup_id
  end
end
