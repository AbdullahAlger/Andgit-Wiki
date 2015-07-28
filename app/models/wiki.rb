class Wiki < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :collaborators
  belongs_to :user
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def is_owned_by?(candidate)
    candidate == user
  end

end
