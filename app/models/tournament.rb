class Tournament < ActiveRecord::Base
  has_many :divisions
  belongs_to :league

  validates_presence_of :name
  validates_uniqueness_of :name

  # TODO maybe this can be made simpler with a scope or join?
  def players
    divisions.collect do |division|
      division.teams.collect do |team|
        team.players
      end.flatten
    end.flatten
  end
end
