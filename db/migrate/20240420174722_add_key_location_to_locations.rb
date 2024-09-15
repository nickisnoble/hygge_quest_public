class AddKeyLocationToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :is_key, :boolean, default: false
  end
end
