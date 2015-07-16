class Team < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :players
  belongs_to :division

  has_many :team_captains
  has_many :captains, through: :team_captains, source: :player

  accepts_nested_attributes_for :players #, reject_if: :new_record?
end
