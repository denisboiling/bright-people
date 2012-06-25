class AddAdressDummyFieldToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :address_dummy, :string
  end
end
