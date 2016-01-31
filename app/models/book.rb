class Book < ActiveRecord::Base
  has_many :pages, -> { order 'position DESC' }
  belongs_to :user

  validates :title, presence: true
  validates :title_color, presence: true

  def cover_page
    pages.first || NullPage.new
  end

  def length
    pages.count
  end

  def next_position
    (pages.last || NullPage.new).position + 1
  end

  def published?
    pages.any?
  end

  def self.featured
    Book.where(featured: true).limit(12).order("RANDOM()")
  end

  def self.title_colors
    ['Gray',
     'Aqua',
     'Black',
     'Blue',
     'Fuchsia',
     'Green',
     'Lime',
     'Maroon',
     'Navy',
     'Olive',
     'Purple',
     'Red',
     'Silver',
     'Teal',
     'White',
     'Yellow']
  end
end
