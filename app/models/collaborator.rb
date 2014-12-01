class Collaborator < ActiveRecord::Base
 belongs_to :user
 belongs_to :wiki
 accepts_nested_attributes_for :user

end
