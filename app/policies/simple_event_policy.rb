class SimpleEventPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user&.author?(record)
  end

  def destroy?
    user&.author?(record)
  end
end
