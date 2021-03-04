class AddUserToFriends < ActiveRecord::Migration[5.2]
  def change
    add_reference :friends, :user_id, foreign_key: true
  end
end
