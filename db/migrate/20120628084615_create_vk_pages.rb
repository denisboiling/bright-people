class CreateVkPages < ActiveRecord::Migration
  def change
    create_table :vk_pages do |t|
      t.string :login
      t.string :password
      t.string :public_url, :default => 'vk.com/yarkieludifestival'
      t.string :public_id, :default => '-39665521'
      t.timestamps
    end
  end
end
