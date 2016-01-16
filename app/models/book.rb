class Book < ActiveRecord::Base
  has_many :pages
  belongs_to :user

  def cover_page
    pages.first || NullPage.new
  end
end
