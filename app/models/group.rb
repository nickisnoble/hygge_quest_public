class Group < ApplicationRecord
  has_many :members, class_name: "Guest"

  normalizes :name, with: ->(name) { name.strip }
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
