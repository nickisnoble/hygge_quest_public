class CreateParties < ActiveRecord::Migration[7.1]
  def change
    create_table :parties do |t|
      t.text :notes
      t.boolean :rsvp

      t.timestamps
    end
  end
end
