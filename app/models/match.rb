##
# A match is a record of a chess game played in a given round and played by 2 teams
# with a lineup of players.
class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team', optional: true
  belongs_to :guest_team, class_name: 'Team', optional: true

  belongs_to :home_team_lineup, class_name: 'Lineup', optional: true
  belongs_to :guest_team_lineup, class_name: 'Lineup', optional: true

  belongs_to :round
  #TODO belongs_to :result

  # names are not really unique
  #validates_uniqueness_of :name, allow_blank: true
end
