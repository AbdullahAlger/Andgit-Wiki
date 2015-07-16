class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable, :lockable

  has_many :wiki, dependent: :destroy

  attr_accessor :role

  USER_ROLES = {
      admin: 0,
      standard: 10,
      premium: 20
  }

  def set_as_admin
    self.role = USER_ROLES[:admin]
  end

  def set_as_premium
    self.role = USER_ROLES[:premium]
  end

  def set_as_standard
    self.role = USER_ROLES[:standard]
  end

end
