class AddCodeToVideoUrls < ActiveRecord::Migration
  def change
    add_column :video_urls, :code, :string
  end
end
