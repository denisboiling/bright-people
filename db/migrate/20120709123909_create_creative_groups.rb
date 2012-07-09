class CreateCreativeGroups < ActiveRecord::Migration
  def change
    create_table :creative_groups do |t|
      t.string :name, :description, :profession
      t.has_attached_file :avatar
      t.timestamps
    end
  end
end
