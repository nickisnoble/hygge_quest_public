class AddAdminToGuests < ActiveRecord::Migration[7.1]
  def change
    add_column :guests, :admin, :boolean, default: false
  end
end
