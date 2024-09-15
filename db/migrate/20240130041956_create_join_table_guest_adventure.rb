class CreateJoinTableGuestAdventure < ActiveRecord::Migration[7.1]
  def change
    create_join_table :guests, :adventures do |t|
      # t.index [:guest_id, :adventure_id]
      # t.index [:adventure_id, :guest_id]
    end
  end
end
