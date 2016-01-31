class PagesController < ApplicationController
  before_action :find_user
  before_action :find_book, except: :show

  def new
    @page = @book.pages.new
  end

  def create
    @page = @book.pages.new(page_params.merge(position: @book.next_position))
    if @page.save
      redirect_to user_book_page_path(@user, @book, @page)
    else
      #TODO: make sure this works
      render 'new'
    end
  end

  def show
    @book = @user.books.find(params[:book_id])
    @page = @book.pages.find_by!(position: params[:id])
  end

  def edit
    @page = @book.pages.find_by!(position: params[:id])
  end

  def index
  end

  private

  def page_params
    params.require(:page).permit(:text, :flickr_photo_id)
  end

  def find_user
    @user = User.find_by('lower(username) = ?', params[:user_id].downcase)
  end

  def find_book
    @book = current_user.books.find(params[:book_id])
  end
end
