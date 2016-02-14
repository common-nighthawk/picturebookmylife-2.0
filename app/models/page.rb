class Page < ActiveRecord::Base
  belongs_to :book
  validates :flickr_photo_id, presence: true

  def image_url(size=nil)
    response = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=" + api_key + "&photo_id=" + flickr_photo_id + "&format=json&nojsoncallback=1")
    json = JSON.parse(response.body)
    unless json['stat'] == 'fail'
      photos = json['sizes']['size']
      photo = (photos[size] if size) || photos.last
      photo['source']
    end
  end

  def next_page
    book.pages.find_by(position: position + 1)
  end

  def previous_page
    book.pages.find_by(position: position - 1)
  end

  private

  def api_key
    '0ce9a627e075627628e07d3280ae1efe'
  end
end
