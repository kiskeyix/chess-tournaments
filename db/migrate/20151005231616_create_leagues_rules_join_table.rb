class CreateLeaguesRulesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :leagues, :rules do |t|
      t.index [:league_id, :rule_id]
      t.index [:rule_id, :league_id]
    end
  end
end
