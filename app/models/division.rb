class Division < ActiveRecord::Base
  has_many :players, through: :divisions_players
  belongs_to :tournament
  has_and_belongs_to_many :teams
end
