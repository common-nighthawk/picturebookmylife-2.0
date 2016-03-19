class PagesController < ApplicationController
  before_action :find_user
  before_action :find_current_user_book, except: :show
  before_action :find_book, only: :show
  before_action :find_page, only: [:show, :edit, :update, :destroy]

  def index
    fresh_when(@book)
    @pages = @book.pages
  end

  def new
    @page = @book.pages.new
  end

  def create
    @page = @book.pages.new(page_params)
    if @page.save
      flash.clear
      redirect_to user_book_page_path(@user, @book, @page)
    else
      flash[:alert] = @page.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def show
    fresh_when(@book)
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

  def find_current_user_book
    @book = current_user.books.find(params[:book_id])
  end

  def find_book
    @book = @user.books.find(params[:book_id])
  end

  def find_page
    @page = @book.pages.find(params[:id])
  end
end
