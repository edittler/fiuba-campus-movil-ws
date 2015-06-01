class AddFileTypeToUploadedDatum < ActiveRecord::Migration
  def change
    add_column :uploaded_data, :file_type, :string
  end
end
