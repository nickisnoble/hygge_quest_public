class CreateMailings < ActiveRecord::Migration[7.1]
  def change
    create_table :mailings do |t|
      t.string :subject

      t.timestamps
    end
  end
end
