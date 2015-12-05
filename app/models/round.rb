class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches
  validate :date_is_within_tournament
  before_destroy :cannot_remove_round_with_matches

  accepts_nested_attributes_for :matches, allow_destroy: true

  def date_is_within_tournament
    errors.add(:start_date, 'Must have start date within tournament') unless start_date >= tournament.start_date and start_date <= tournament.end_date
    errors.add(:end_date, 'Must have end date within tournament') unless end_date >= tournament.start_date and end_date <= tournament.end_date
  end

  private

  def cannot_remove_round_with_matches
    if matches.size > 0
      msg = 'Cannot remove rounds with associated matches. Remove all matches first.'
      Rails.logger.error "#{__method__}: #{msg}"
      errors.add(:base, msg)
      return false
    end
    true
  end
end
