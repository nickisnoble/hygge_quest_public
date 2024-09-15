class Mailing < ApplicationRecord
  has_rich_text :body
  has_and_belongs_to_many :guests
  validates :subject, :body, presence: true
  validates :guests, length: { minimum: 1, message: "must have at least one selected" }
end
