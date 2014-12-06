class Wiki < ActiveRecord::Base

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  scope :public, -> { where(:private => false) }
  scope :private, -> { where(:private => true) }
  scope :order_by_newest, -> { order('created_at DESC') }

  def has_collaborators?
    self.collaboration == true
  end

  def can_be_collaboration?
    user.upgraded? && private == true
  end


end
