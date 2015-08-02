class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable, :lockable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, through: :wikis

  validates :role, presence: true, inclusion: { in: %w(standard premium admin), message: "should be one of admin, premium, standard" }


  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def standard?
    role == 'standard'
  end

  def upgrade_account
    if self.upgradeable?
      self.update_attributes(role: "premium")
    end
  end

  def can_privatize_wiki?(wiki)
    (self.premium? && wiki.is_owned_by?(self)) || self.admin?
  end

  def make_wikis_public
    wikis.each do |wiki|
      wiki.update_attributes(private: false)
    end
  end

  def downgrade_account
    if self.premium?
      self.update_attributes(role: "standard")
      self.make_wikis_public
    end
  end

  def can_manage_collaborators?(wiki)
    self.admin? || (self.premium? && wiki.is_owned_by?(self))
  end

  def upgradeable?
    self.standard?
  end

end
