class Game < ActiveRecord::Base
  belongs_to :division
  has_and_belongs_to_many :players

  # none and public means all can see this game
  # teams means both teams for which the player is member can see
  # private means only players themselves can see
  VISIBILITY = [ '', 'public', 'teams', 'private' ]
end
