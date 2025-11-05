class DropQuestsAndAchievements < ActiveRecord::Migration[7.1]
  def change
    drop_table :guests_achievements, if_exists: true
    drop_table :achievements, if_exists: true
    drop_table :quests, if_exists: true
  end
end
