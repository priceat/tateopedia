class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.present?
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end

end