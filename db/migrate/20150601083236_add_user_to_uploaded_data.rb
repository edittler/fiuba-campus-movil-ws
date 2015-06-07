class AddUserToUploadedData < ActiveRecord::Migration
  def change
    add_reference :uploaded_data, :user, index: true, foreign_key: true
  end
end
