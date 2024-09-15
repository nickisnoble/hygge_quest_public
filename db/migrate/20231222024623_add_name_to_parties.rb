class AddNameToParties < ActiveRecord::Migration[7.1]
  def change
    add_column :parties, :name, :string
  end
end
