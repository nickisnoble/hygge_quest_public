class RenameAdminToDmOnGuests < ActiveRecord::Migration[7.1]
  def change
    rename_column :guests, :admin, :dungeon_master
  end
end
