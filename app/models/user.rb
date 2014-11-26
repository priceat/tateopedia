class User < ActiveRecord::Base
  has_many :wikis
  accepts_nested_attributes_for :wikis

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
     
  after_initialize :set_default_role, :if => :new_record?

  validates :role, inclusion: { in: ['standard', 'premium', 'admin'].freeze }


  def set_default_role
    self.role ||= :standard
  end

  def destroy_private_wikis
    wikis.where(private: true).destroy_all
  end

  def upgraded?
    role == ('premium' || 'admin')
  end
  
end
