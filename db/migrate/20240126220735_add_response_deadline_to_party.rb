class AddResponseDeadlineToParty < ActiveRecord::Migration[7.1]
  def change
    add_column :parties, :response_deadline, :date

    Party.update_all(response_deadline: "2024-01-31")
  end
end
