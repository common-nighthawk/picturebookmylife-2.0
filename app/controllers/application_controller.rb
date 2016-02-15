class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def find_user
    @user = User.find_by('lower(username) = ?', params[:user_id].downcase)
  end
end
