class Player < ActiveRecord::Base
  belongs_to :user # even if user is destroyed, we keep player around

  validates_presence_of :name
  validates_uniqueness_of :name # TODO name should be stripped

  has_and_belongs_to_many :teams
  has_many :team_captains, dependent: :destroy # TODO when you remove this player from team, it should remove team_captain
  has_many :captain_of_teams, through: :team_captains, source: :team

  def last_ratings_per_league
    # TODO choose last rating per each league the user is in, return Rating object
  end
  def tournaments
    Division.joins(:teams => :players).where('players.id = ?',id).collect do |division|
      division.tournament
    end
  end
  def open_tournaments
    today = Time.now
    tournaments.collect do |tournament|
      tournament if tournament.end_date >= today
    end.compact
  end
  def past_tournaments
    today = Time.now
    tournaments.collect do |tournament|
      tournament if tournament.end_date < today
    end.compact
  end
end
