class PagesController < ApplicationController
  before_action :find_user
  before_action :find_my_book, except: :show
  before_action :find_any_book, only: :show
  before_action :find_page, only: [:show, :edit, :update, :destroy]

  def new
    @page = @book.pages.new
  end

  def create
    @page = @book.pages.new(page_params)
    @page.position = @book.next_position
    if @page.save
      flash.clear
      redirect_to user_book_page_path(@user, @book, @page)
    else
      flash[:alert] = @page.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @page.update_attributes(page_params)
      flash.clear
      redirect_to user_book_page_path(@user, @book, @page)
    else
      flash[:alert] = @page.errors.full_messages.to_sentence
      render :edit
    end
  end

  def index
    @pages = @book.pages
  end

  def destroy
    if @page.destroy
      flash.clear
      redirect_to user_book_path(@user, @book)
    else
      flash[:alert] = @page.errors.full_messages.to_sentence
      render :show
    end
  end

  private

  def page_params
    params.require(:page).permit(:text, :flickr_photo_id)
  end

  def find_user
    @user = User.find_by('lower(username) = ?', params[:user_id].downcase)
  end

  def find_my_book
    @book = current_user.books.find(params[:book_id])
  end

  def find_any_book
    @book = @user.books.find(params[:book_id])
  end

  def find_page
    @page = @book.pages.find(params[:id])
  end
end
