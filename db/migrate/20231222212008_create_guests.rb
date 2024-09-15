class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.string :name

      t.string :email
      t.index "LOWER(email)", unique: true, name: "index_users_on_lowercase_email"

      t.text :notes
      t.boolean :under_13
      t.integer :food_preference
      t.references :party, null: false, foreign_key: true

      t.timestamps
    end
  end
end
