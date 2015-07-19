class WikiPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all
      else
        scope.where(private: false)
      end
    end
  end

  def index
    true
  end

  def destroy
    user.present? && (record.user == user || user.admin?)
  end

end