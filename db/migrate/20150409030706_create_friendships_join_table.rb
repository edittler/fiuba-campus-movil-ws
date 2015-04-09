class CreateFriendshipsJoinTable < ActiveRecord::Migration
  def change
    #create_join_table :users, :users, table_name: :friendships do |t|
    #  t.index [:this_user_id, :other_user_id]
    #  t.index [:other_user_id, :this_user_id]
    #end

    create_table :friendships, id: false do |t|
      t.integer :this_user_id,  null: false
      t.integer :other_user_id, null: false
    end

    add_index :friendships, :this_user_id
    add_index :friendships, :other_user_id
  end
end
