class Tournament < ActiveRecord::Base
  has_many :divisions
  has_many :rounds
  belongs_to :league

  accepts_nested_attributes_for :rounds, allow_destroy: true
  accepts_nested_attributes_for :divisions, allow_destroy: true

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :boards_per_match
  validates :boards_per_match, inclusion: { in: (1..100).to_a,
    message: "%{value} is not a valid size" }

  def teams
    Team.joins(:divisions => :tournament).where('tournaments.id = ?',id).group(:id)
  end

  def players
    Player.joins(:teams => :divisions).where('tournament_id = ?', id)
  end

  # returns division for this tournament and player
  # note that a user can only be competing with 1 team in 1 division of every tournament
  def player_divisions(player)
    Division.joins(:teams => :players).where('tournament_id = ? AND players.id = ?', id, player.id).uniq.last
  end

  # returns team for this tournament and player
  # note that a user can only be competing with 1 team in 1 division of every tournament
  def player_team(player)
    Team.joins(:players).where( 'players_teams.player_id = ?', player.id ).uniq.last
  end

  def self.open_tournaments
    today = Time.now
    where('end_date >= ?', today).group(:id)
  end
end
