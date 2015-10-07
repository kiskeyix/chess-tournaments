class Division < ActiveRecord::Base
  belongs_to :tournament
  has_and_belongs_to_many :teams
  accepts_nested_attributes_for :teams #, reject_if: :new_record?, allow_destroy: true
  def name_with_tournament
    "#{tournament.respond_to?(:name) ? tournament.name : "No Tournament Yet"} - #{name}"
  end
  def self.open_tournaments
    joins(:tournament).where('tournaments.end_date >= ?',Time.now)
  end
end
