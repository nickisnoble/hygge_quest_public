class AddCompletableWithToQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :completable_with, :integer
  end
end
