class Division < ActiveRecord::Base
  has_many :players, through: :divisions_players
  belongs_to :tournament
end
