class Lineup < ActiveRecord::Base
  belongs_to :match
  belongs_to :team

  has_many :lineups_line_items
  accepts_nested_attributes_for :lineups_line_items, allow_destroy: true
end
