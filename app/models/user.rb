class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable, :lockable

  has_many :wiki, dependent: :destroy

  after_initialize :init

  def init
    if new_record?
      self.role ||= "standard"
    end
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def upgrade_account
    self.update_attributes(role: "premium")
  end

end
