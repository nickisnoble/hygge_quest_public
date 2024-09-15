class RenameMailingsGuestsToGuestsMailings < ActiveRecord::Migration[7.1]
  def change
    # rails expects alphabetical order!
    rename_table :mailings_guests, :guests_mailings
  end
end
