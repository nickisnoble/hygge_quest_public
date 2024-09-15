class RenameCategoryToIconOnLocations < ActiveRecord::Migration[7.1]
  def change
    rename_column :locations, :category, :icon
  end
end
