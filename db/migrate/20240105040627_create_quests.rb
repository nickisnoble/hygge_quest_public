class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.string :title
      t.text :description
      t.integer :xp
      t.string :reward

      t.timestamps
    end
  end
end
