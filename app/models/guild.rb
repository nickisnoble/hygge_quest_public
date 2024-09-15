class Guild < ApplicationRecord
  has_many :members, class_name: "Guest"
  has_one_attached :icon
  has_one_attached :background
  has_many_attached :looks

  normalizes :name, with: ->(name) { name.strip }
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  before_save :assign_slug

  scope :joinable, -> { where(secret: false) }

  def to_param
    slug
  end

  private

  def assign_slug
    self.slug ||= name.parameterize
  end
end
