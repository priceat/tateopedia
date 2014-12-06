class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  default_scope { order('updated_at DESC') }
end
