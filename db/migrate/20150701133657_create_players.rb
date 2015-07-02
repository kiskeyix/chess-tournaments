class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id
      t.string :name
      t.string :nationality
      t.string :gender
      t.string :image

      t.timestamps null: false
    end
  end
end
