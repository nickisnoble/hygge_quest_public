class RenameDungeonMasterToAdmin < ActiveRecord::Migration[7.1]
  def change
    rename_column :guests, :dungeon_master, :admin
  end
end
