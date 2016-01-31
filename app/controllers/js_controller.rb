class JsController < ApplicationController
  def photo
    page = Page.new(flickr_photo_id: params[:id])
    render json: { photo_url: page.image_url(6) }
  end
end
