class Book < ActiveRecord::Base
  has_many :pages
  belongs_to :user

  def cover_page
    pages.first || NullPage.new
  end

  def self.featured
    Book.where(featured: true).limit(12).order("RANDOM()")
  end
end
