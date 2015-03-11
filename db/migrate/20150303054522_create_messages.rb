class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.datetime :sent
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :messages, :users
  end
end
