class Achievement < ApplicationRecord
  belongs_to :quest
  has_and_belongs_to_many :guests

  def mark_complete!
    return if complete?

    self.complete = true
    touch(:completed_at)
  end
end
