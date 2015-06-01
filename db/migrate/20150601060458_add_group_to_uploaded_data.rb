class AddGroupToUploadedData < ActiveRecord::Migration
  def change
    add_reference :uploaded_data, :group, index: true, foreign_key: true
  end
end
