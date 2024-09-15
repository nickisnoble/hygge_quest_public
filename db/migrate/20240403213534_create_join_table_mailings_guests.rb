class CreateJoinTableMailingsGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :mailings_guests, id: false do |t|
      t.belongs_to :mailing
      t.belongs_to :guest
    end

    add_index :mailings_guests, [:mailing_id, :guest_id], unique: true
  end
end
