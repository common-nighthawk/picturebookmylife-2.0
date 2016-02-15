module ApplicationHelper
  def current_user?(user)
    user == current_user
  end

  def profile_page?
    action_name == 'index' && controller_name == 'books'
  end
end
