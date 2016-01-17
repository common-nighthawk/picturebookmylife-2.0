class BooksController < ApplicationController
  before_action :find_user

  def show
    @book = @user.books.find(params[:id])
  end

  def index
  end

  private

  def find_user
    @user = User.find_by('lower(username) = ?', params[:user_id].downcase)
  end
end
