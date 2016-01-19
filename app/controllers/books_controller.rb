class BooksController < ApplicationController
  before_action :find_user
  before_action :find_book, except: [:index, :new, :create]

  def index
  end

  def new
    @book = @user.books.new
  end

  def create
    @book = @user.books.new(book_params)
    if @book.save
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
    raise
  end

  def destroy
    raise
  end

  private

  def book_params
    params.require(:book).permit(:title, :title_color)
  end

  def find_user
    @user = User.find_by('lower(username) = ?', params[:user_id].downcase)
  end

  def find_book
    @book = @user.books.find(params[:id])
  end
end
