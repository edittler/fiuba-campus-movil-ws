class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :this_user_id,  null: false
      t.integer :other_user_id, null: false

      t.timestamps null: false
    end

    add_index :friendships, :this_user_id
    add_index :friendships, :other_user_id
  end
end
