class AddDateToComments < ActiveRecord::Migration
  def change
    add_column :comments, :date, :string
  end
end
