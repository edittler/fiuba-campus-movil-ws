class RenameFirstNameColumnToFirstn < ActiveRecord::Migration
  def self.up
    rename_column :profiles, :first_name, :firstn
  end

  def self.down
    rename_column :profiles, :firstn, :first_name
  end
end
