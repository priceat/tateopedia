class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
     
  before_create :standard

  def admin?
   role == 'admin'
  end
 
  def premium?
   role == 'premium'
  end

  private

   def standard
    role = 'standard'
   end

end
