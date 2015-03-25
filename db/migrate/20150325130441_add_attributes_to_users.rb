class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :padron, :string, null: false, default: ""
    add_index :users, :padron, unique: true
    add_column :users, :biography, :string
    add_column :users, :nationality, :string
    add_column :users, :current_city, :string
    add_column :users, :cell_phone, :string
  end
end
