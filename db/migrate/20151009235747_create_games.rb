class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :event
      t.string :name
      t.datetime :date
      t.string :timecontrol
      t.string :while_elo
      t.string :black_elo
      t.string :site
      t.string :result
      t.string :fen
      t.text :pgn
      t.string :visibility
      t.integer :division_id

      t.timestamps null: false
    end

    add_index "games", ["name"], name: "index_games_on_name"
    add_index "games", ["event"], name: "index_games_on_event"
  end
end
