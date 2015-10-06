class Team < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :players
  # you cannot join a tournament, you always are in a division of a tournament
  has_and_belongs_to_many :divisions

  has_many :team_captains
  has_many :captains, through: :team_captains, source: :player, dependent: :destroy

  accepts_nested_attributes_for :players, reject_if: :new_record?, allow_destroy: true
  #accepts_nested_attributes_for :players, reject_if: :players_must_not_be_captain,
  #  allow_destroy: true
  accepts_nested_attributes_for :divisions #, reject_if: :new_record?, allow_destroy: true

  #def players_must_not_be_captain(attributes)
  #  logger.info attributes
  #  new_record? or true #FIXME
  #end
end
