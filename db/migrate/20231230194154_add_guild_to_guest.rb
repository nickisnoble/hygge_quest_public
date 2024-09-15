class AddGuildToGuest < ActiveRecord::Migration[7.1]
  def change
    # Can be null for new guests
    add_reference :guests, :guild, foreign_key: true
  end
end
