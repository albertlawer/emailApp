class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 30.minutes
  

  belongs_to :role 


  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, on: create
  validates :password_confirmation, presence: true, on: create
  validates :username, presence: true
  validates :role_id, presence: true
      
    

  def super_admin?
    self.role.name == "Super Admin"
  end
  
end
