class League < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :rules
  accepts_nested_attributes_for :rules #, reject_if: :new_record?, allow_destroy: true
end
