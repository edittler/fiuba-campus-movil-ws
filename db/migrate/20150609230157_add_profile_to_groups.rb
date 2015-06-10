class AddProfileToGroups < ActiveRecord::Migration
  def self.up
    add_attachment :groups, :picture
  end

  def self.down
    remove_attachment :groups, :picture
  end
end

