class Page < ActiveRecord::Base
  belongs_to :book, touch: true

  validates :book, presence: true
  validates :position, presence: true
  validates :flickr_photo_id, presence: true

  validates :position, uniqueness: { scope: :book }

  before_validation :set_position, on: :create

  def image_url(size=nil)
    json = fetch_flickr_json
    unless json['stat'] == 'fail'
      photos = json['sizes']['size']
      size ? photos[size]['source'] : photos.last['source']
    end
  end

  def next_page
    book.pages.find_by(position: position + 1)
  end

  def previous_page
    book.pages.find_by(position: position - 1)
  end

  private

  def set_position
    self.position = book.next_position
  end

  def fetch_flickr_json
    JSON.parse(HTTParty.get(remote_images_url).body)
  end

  def remote_images_url
    "https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=" + api_key + "&photo_id=" + flickr_photo_id + "&format=json&nojsoncallback=1"
  end

  def api_key
    '0ce9a627e075627628e07d3280ae1efe'
  end
end
