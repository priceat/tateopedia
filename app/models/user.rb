class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
     
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :standard
  end

  def admin?
   role == 'admin'
  end
 
  def premium?
   role == 'premium'
  end


end
