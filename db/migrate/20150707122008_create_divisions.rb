class CreateDivisions < ActiveRecord::Migration[4.2]
  def change
    create_table :divisions do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :tournament_id

      t.timestamps null: false
    end
  end
end
