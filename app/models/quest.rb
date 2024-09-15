class Quest < ApplicationRecord
  has_many :achievements

  normalizes :title, :description, with: ->string { string.strip }
  validates :title, presence: true, uniqueness: true
  validates :xp, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # conquest types
  enum completable_with: {
    checkbox: 0,
    image: 1,
    form: 2
  }
end
