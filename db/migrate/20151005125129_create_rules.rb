class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name
      t.text :summary
      t.text :body

      t.timestamps null: false
    end

    add_index "rules", ["name"], name: "index_rules_on_name"
  end
end
