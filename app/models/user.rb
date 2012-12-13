class User < ActiveRecord::Base
  has_many :roles, :dependent => :destroy
  has_many :clubs, :through => :roles
  has_many :notes
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def admin?(club)
  	r = self.roles.find_by_club_id(club.id)
    return r.is_admin
  end

  def coach?(club)
  	r = self.roles.find_by_club_id(club.id)
    return r.is_coach
  end

  def doctor?(club)
  	r = self.roles.find_by_club_id(club.id)
    return r.is_doctor
  end

  def manager?(club)
  	r = self.roles.find_by_club_id(club.id)
    return r.is_manager
  end

end
