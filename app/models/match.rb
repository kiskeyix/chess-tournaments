class Match < ActiveRecord::Base
  belongs_to :home_team, nil, class_name: :team
  belongs_to :guest_team, nil, class_name: :team

  belongs_to :home_team_lineup, nil, class_name: :lineup
  belongs_to :guest_team_lineup, nil, class_name: :lineup

  belongs_to :round
  #TODO belongs_to :result

  validates_uniqueness_of :name, allow_blank: true
end
