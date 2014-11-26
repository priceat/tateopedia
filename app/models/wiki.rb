class Wiki < ActiveRecord::Base
  #attr_accessible :body, :title, :private

  belongs_to :user, touch: true

  after_initialize :set_default_access, :if => :new_record?

  scope :public, -> { where(:private => false) }
  scope :private, -> { where(:private => true) }

    def set_default_access
    self.private ||= false
    end


end
