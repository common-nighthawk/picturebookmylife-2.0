module ApplicationHelper
  def current_user?(user)
    user == current_user
  end

  def profile_page?
    action_name == 'index' && controller_name == 'books'
  end

  def destroy_book_confirmation
    'Are you sure you want to delete this book? All the pages will be lost.'
  end

  def destroy_page_confirmation
    'Are you sure you want to delete this page?'
  end
end
