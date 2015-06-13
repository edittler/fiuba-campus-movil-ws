class AddBannedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :banned, :boolean, :default => false, :null => false
    add_index  :users, :banned
  end

  def self.down
    remove_index  :users, :banned
    remove_column :users, :banned
  end
end
