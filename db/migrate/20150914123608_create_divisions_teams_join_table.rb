class CreateDivisionsTeamsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :divisions, :teams do |t|
      t.index [:division_id, :team_id]
      t.index [:team_id, :division_id]
    end
  end
end
