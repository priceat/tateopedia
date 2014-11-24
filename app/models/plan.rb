class Plan < ActiveRecord::Base
  attr_accessible :name
  has_many :subscriptions
end
