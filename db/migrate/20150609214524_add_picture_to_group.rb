class AddPictureToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :picture_file_name, :string
    add_column :groups, :picture_content_type, :string
    add_column :groups, :picture_file_size, :integer
    add_column :groups, :picture_updated_at, :datetime
  end
end
