class RenameLastNameColumnToLastn < ActiveRecord::Migration
  def self.up
    rename_column :profiles, :last_name, :lastn
  end

  def self.down
    rename_column :lastn, :username, :last_name
  end
end
