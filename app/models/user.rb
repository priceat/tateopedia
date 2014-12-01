class User < ActiveRecord::Base

  has_many :wikis
  has_many :collaborators
  belongs_to :collaborators
  accepts_nested_attributes_for :wikis

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
     
  after_initialize :set_default_role, :if => :new_record?

  validates :role, inclusion: { in: ['standard', 'premium', 'admin'].freeze }

  scope :not, ->(id) { where('id != ?', id) }
  scope :viewable, -> { where(:member => true) }


  def set_default_role
    self.role ||= :standard
  end

  def destroy_private_wikis
    wikis.where(private: true).destroy_all
  end

  def upgraded?
    role == ('premium' || 'admin')
  end

  def collaboration_access?
    upgraded? || member == true
  end


  def collaborations
    wikis = []
      Collaborator.where(user: self).each do |collaboration|
      wikis << Wiki.find(collaboration.wiki_id)
    end
    wikis
  end

  def my_collaborations
    wikis = []
      Wiki.where(user: self).each do |collaboration|
      wikis << Wiki.find(collaboration.wiki_id)
      end
    wikis
  end
end
