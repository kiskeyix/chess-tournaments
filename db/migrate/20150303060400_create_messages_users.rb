class CreateMessagesUsers < ActiveRecord::Migration
  def change
    create_table :messages_users do |t|
      t.references :message, index: true
      t.references :user, index: true
      t.boolean :read, default: false, index: true

      t.timestamps # null: false
    end
    add_foreign_key :messages_users, :messages
    add_foreign_key :messages_users, :users
  end
end
