class PostPolicy < ApplicationPolicy
  def index?
    true # All users can view posts
  end

  def show?
    true # All users can view a post
  end

  def create?
    user.present? # Only authenticated users can create posts
  end

  def update?
    user_is_author?
  end

  def destroy?
    user_is_author?
  end

  private

  def user_is_author?
    record.user_id == user.id
  end
end
