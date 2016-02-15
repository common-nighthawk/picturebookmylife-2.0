class BooksController < ApplicationController
  before_action :find_user
  before_action :find_book, except: [:index, :new, :create]

  def index
    @books = @user == current_user ? @user.books : @user.books.published
  end

  def new
    @book = @user.books.new
  end

  def create
    @book = @user.books.new(book_params)
    if @book.save
      flash.clear
      redirect_to user_book_path(@user, @book)
    else
      flash[:alert] = @book.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update_attributes(book_params)
      flash.clear
      redirect_to user_book_path(@user, @book)
    else
      flash[:alert] = @book.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash.clear
      redirect_to user_books_path(@user)
    else
      flash[:alert] = @book.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :title_color)
  end

  def find_book
    @book = @user.books.find(params[:id])
  end
end
