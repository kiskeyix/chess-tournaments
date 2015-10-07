class Tournament < ActiveRecord::Base
  has_many :divisions
  belongs_to :league

  validates_presence_of :name
  validates_uniqueness_of :name

  def players
    Player.joins(:teams => :divisions).where('tournament_id = ?', id)
  end

  # returns division for this tournament and player
  # note that a user can only be competing with 1 team in 1 division of every tournament
  def player_divisions(player)
    Division.joins(:teams => :players).where('tournament_id = ? AND players.id = ?', id, player.id).first
  end
end
