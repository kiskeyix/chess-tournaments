class Tournament < ActiveRecord::Base
  has_many :divisions
  has_many :players, through: :divisions
end
