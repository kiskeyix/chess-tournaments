class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :tournament_id

      t.timestamps null: false
    end
    add_index :rounds, :name
    add_index :rounds, :tournament_id
  end
end
