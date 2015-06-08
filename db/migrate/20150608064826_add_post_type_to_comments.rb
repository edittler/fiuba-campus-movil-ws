class AddPostTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :post_type, :string, :default => "comment"
  end
end
