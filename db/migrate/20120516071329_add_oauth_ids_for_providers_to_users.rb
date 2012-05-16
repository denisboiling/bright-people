class AddOauthIdsForProvidersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string
    add_column :users, :vkontakte_id, :string
    add_column :users, :odnoklassniki_id, :string
    
    add_index :users, :facebook_id
    add_index :users, :vkontakte_id
    add_index :users, :odnoklassniki_id
  end
end
