class Page < ActiveRecord::Base
  belongs_to :book

  def image_url
    api_key = "0ce9a627e075627628e07d3280ae1efe"
    photo_id = self.flickr_photo_id
    r = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=" + api_key + "&photo_id=" + photo_id + "&format=json&nojsoncallback=1")
    x = JSON.parse(r.body)
    x['sizes']['size'][8]['source']
  end
end
