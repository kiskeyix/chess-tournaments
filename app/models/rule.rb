class Rule < ActiveRecord::Base
   validates_presence_of :name
   validates_uniqueness_of :name

   has_and_belongs_to_many :leagues

   # TODO maybe tournaments need to have their own rules?
   #has_and_belongs_to_many :tournaments
end
