class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :text
      t.string :permalink, null: false
      t.timestamps
    end
  end
end
