class Tournament < ActiveRecord::Base
  has_many :divisions
  # TODO maybe this can be made simpler with a scope or join?
  def players
    divisions.collect do |division|
      division.teams.collect do |team|
        team.players
      end.flatten
    end.flatten
  end
end
