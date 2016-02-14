class JsController < ApplicationController
  def photo
    page = Page.new(flickr_photo_id: params[:id])
    render json: { photo_url: page.image_url(6) }
  end

  def pages
    params[:page].each.with_index(1) do |id, position|
      Page.find(id).update_attribute(:position, position)
    end
    render json: nil
  end
end
