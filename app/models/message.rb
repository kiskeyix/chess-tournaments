class Message < ActiveRecord::Base
  # it turns out that if you actually want attributes in the
  # model that links two models, you must use hm:t associations
  #has_and_belongs_to_many :users
  has_many :messages_users
  has_many :users, through: :messages_users
  belongs_to :user
end
