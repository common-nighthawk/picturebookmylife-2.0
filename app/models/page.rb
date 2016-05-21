class Page < ActiveRecord::Base
  belongs_to :book, touch: true

  validates :book, presence: true
  validates :position, presence: true
  validates :flickr_photo_id, presence: true

  validates :position, uniqueness: { scope: :book }

  before_validation :set_position, on: :create
  before_save :set_image_json

  def image_url(size=nil)
    json = image_json || image_json_from_api
    unless json['stat'] == 'fail'
      photos = json['sizes']['size']
      size = -1 unless (size && photos[size])
      photos[size]['source']
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

  def set_image_json
    self.image_json = image_json_from_api if flickr_photo_id_changed?
  end

  def image_json_from_api
    JSON.parse(HTTParty.get(api_image_endpoint).body)
  end

  def api_image_endpoint
    "https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=" + api_key + "&photo_id=" + flickr_photo_id + "&format=json&nojsoncallback=1"
  end

  def api_key
    '0ce9a627e075627628e07d3280ae1efe'
  end
end
