class Tournament < ActiveRecord::Base
  has_many :divisions
  belongs_to :league

  validates_presence_of :name
  validates_uniqueness_of :name

  def players
    Player.joins(:teams => :divisions).where('tournament_id = ?', id)
  end
end
