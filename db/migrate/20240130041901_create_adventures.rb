class CreateAdventures < ActiveRecord::Migration[7.1]
  def change
    create_table :adventures do |t|
      t.string :type
      t.references :quest, null: false, foreign_key: true
      t.boolean :completed
      t.datetime :completed_at

      t.timestamps
    end
  end
end
