class Wiki < ActiveRecord::Base

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  after_initialize :set_default_access, :if => :new_record?

  scope :public, -> { where(:private => false) }
  scope :private, -> { where(:private => true) }

    def set_default_access
      self.private ||= false
    end

    def joint?
      self.collaboration == true
    end

    def can_be_collaboration?
     user.upgraded? && private == true
    end


end
