class Collaborator < ActiveRecord::Base
 belongs_to :user
 belongs_to :wiki
 accepts_nested_attributes_for :user

 def wiki_collaborators
    users = []
      Wiki.where(collaboration: true).each do |wiki_collaborator|
      users << User.find(Collaborator.user_id)
      end
    users
 end



end
