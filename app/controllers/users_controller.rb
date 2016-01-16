class UsersController < ApplicationController
  def show
    @user = User.find_by!('lower(username) = ?', params[:id].downcase)
  end
end
