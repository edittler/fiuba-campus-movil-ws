class CreateUploadedData < ActiveRecord::Migration
  def change
    create_table :uploaded_data do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
