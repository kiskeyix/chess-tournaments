class CreateTeamCaptains < ActiveRecord::Migration
  def change
    create_table :team_captains do |t|
      t.integer :team_id
      t.integer :player_id

      t.timestamps null: false
    end
  end
end
