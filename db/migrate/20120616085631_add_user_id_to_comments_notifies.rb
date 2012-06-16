class AddUserIdToCommentsNotifies < ActiveRecord::Migration
  def change
    add_column :user_comment_notifies, :user_id, :integer
  end
end
