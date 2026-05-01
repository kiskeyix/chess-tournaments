class CreateTournaments < ActiveRecord::Migration[4.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :image
      t.text :description

      t.timestamps null: false
    end
  end
end
