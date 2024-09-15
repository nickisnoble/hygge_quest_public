class Location < ApplicationRecord
  validates :name, :address, presence: true
  validates :address, uniqueness: {case_sensitive: true}

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }

  before_save :set_default_icon

  private

  def set_default_icon
    self.icon ||= "sign-post"
  end
end
