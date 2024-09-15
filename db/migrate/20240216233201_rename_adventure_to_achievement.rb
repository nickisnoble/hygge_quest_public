class RenameAdventureToAchievement < ActiveRecord::Migration[7.1]
  def change
    rename_table :adventures, :achievements
    rename_table :adventures_guests, :guests_achievements

    rename_column :guests_achievements, :adventure_id, :achievement_id
  end
end
