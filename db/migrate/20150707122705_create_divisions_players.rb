class CreateDivisionsPlayers < ActiveRecord::Migration
  def change
    create_table :divisions_players do |t|
      t.integer :player_id
      t.integer :division_id

      t.timestamps null: false
    end
  end
end
