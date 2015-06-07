class AddUploaderNameToUploadedDatum < ActiveRecord::Migration
  def change
    add_column :uploaded_data, :uploader_name, :string
  end
end
