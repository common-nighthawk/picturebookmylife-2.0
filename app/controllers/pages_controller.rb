class PagesController < ApplicationController
  before_action :find_user
  before_action :find_book

  def show
    @page = @book.pages.find(params[:id])
  end

  private

  def find_user
    @user = User.find_by('lower(username) = ?', params[:user_id].downcase)
  end

  def find_book
    @book = @user.books.find(params[:book_id])
  end
end
