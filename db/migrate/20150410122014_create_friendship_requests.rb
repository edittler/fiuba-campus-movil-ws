class CreateFriendshipRequests < ActiveRecord::Migration
  def change
    create_table :friendship_requests do |t|
      t.integer :sender_user_id,  null: false
      t.integer :receiver_user_id, null: false

      t.timestamps null: false
    end

    add_index :friendship_requests, :sender_user_id
    add_index :friendship_requests, :receiver_user_id
  end
end
