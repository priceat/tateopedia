class User < ActiveRecord::Base
  has_many :wikis

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
     
  after_initialize :set_default_role, :if => :new_record?

  validates :role, inclusion: { in: ['standard', 'premium', 'admin'].freeze }

  def set_default_role
    self.role ||= :standard
  end

  def premium?
    role == 'premium'
  end
  
end
