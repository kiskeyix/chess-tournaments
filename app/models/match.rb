##
# A match is a record of a chess game played in a given round and played by 2 teams
# with a lineup of players.
class Match < ActiveRecord::Base
  belongs_to :home_team, nil, class_name: 'Team'
  belongs_to :guest_team, nil, class_name: 'Team'

  belongs_to :home_team_lineup, nil, class_name: 'Lineup'
  belongs_to :guest_team_lineup, nil, class_name: 'Lineup'

  belongs_to :round
  #TODO belongs_to :result

  # names are not really unique
  #validates_uniqueness_of :name, allow_blank: true
end
