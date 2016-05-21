class AddImageJsonToPages < ActiveRecord::Migration
  def change
    add_column :pages, :image_json, :json

    Page.reset_column_information

    Page.all.each do |page|
      page.image_json = page.send(:image_json_from_api)
      sleep(3)
      page.save!
    end
  end
end
