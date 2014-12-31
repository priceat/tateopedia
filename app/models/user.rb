class User < ActiveRecord::Base

  has_many :wikis
  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
     
  validates :role, inclusion: { in: ['standard', 'premium', 'admin'].freeze }

  scope :not, ->(id) { where('id != ?', id) }
  scope :viewable, -> { where(:member => true) }

  def destroy_private_wikis
    wikis.where(private: true).destroy_all
  end

  def upgraded?
    role == ('premium' || 'admin')
  end

  def collaboration_access?
    upgraded? || member == true
  end

end
