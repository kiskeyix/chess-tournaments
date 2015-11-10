class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches
  validate :date_is_within_tournament

  def date_is_within_tournament
    errors.add(:start_date, 'Must have start date within tournament') unless start_date >= tournament.start_date and start_date <= tournament.end_date
    errors.add(:end_date, 'Must have end date within tournament') unless end_date >= tournament.start_date and end_date <= tournament.end_date
  end
end
