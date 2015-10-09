class Team < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  #TODO see below. should we try to validate that teams are already in this tournament?
  #validate :only_one_division_per_tournament #, on: :update

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

  # TODO
#   def only_one_division_per_tournament
#     logger.info "checking if team is already in this tournament"
#     team_divisions_for_tournament = divisions.where('tournament_id = ?',1)
#     errors.add(:base, 'A team can only be in 1 division per tournament') unless team_divisions_for_tournament.size == 0
#   end
end
