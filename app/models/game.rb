class Game < ActiveRecord::Base
  belongs_to :division
  has_and_belongs_to_many :players
  belongs_to :white_player, class_name: 'Player'
  belongs_to :black_player, class_name: 'Player'

  validates_presence_of :white_player, :black_player

  has_and_belongs_to_many :lineups_line_items

  # none and public means all can see this game
  # teams means both teams for which the player is member can see
  # private means only players themselves can see
  VISIBILITY = [ '', 'public', 'teams', 'private' ]
end
