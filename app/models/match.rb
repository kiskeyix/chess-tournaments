class Match < ActiveRecord::Base
  belongs_to :home_team, nil, class_name: 'Team'
  belongs_to :guest_team, nil, class_name: 'Team'

  belongs_to :home_team_lineup, nil, class_name: 'Lineup'
  belongs_to :guest_team_lineup, nil, class_name: 'Lineup'

  belongs_to :round
  #TODO belongs_to :result

  has_and_belongs_to_many :games

  validates_uniqueness_of :name, allow_blank: true
end
