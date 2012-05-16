class CreateAppConfigs < ActiveRecord::Migration
  def change
    create_table :app_configs do |t|
      
      t.timestamps
    end
  end
end
