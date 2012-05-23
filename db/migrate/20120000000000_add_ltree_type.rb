class AddLtreeType < ActiveRecord::Migration
  def up
    execute "CREATE EXTENSION IF NOT EXISTS ltree"
  end

  def down
    execute "DROP EXTENSION IF EXISTS ltree"
  end
end
