class Wiki < ActiveRecord::Base

  belongs_to :user

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? where(public: false) : all }

  def is_owned_by?(candidate)
    candidate == user
  end

end
