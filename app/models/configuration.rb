class Configuration < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  # Class method to get a configuration value
  def self.get(key, default = nil)
    find_by(key: key)&.value || default
  end

  # Class method to set a configuration value
  def self.set(key, value)
    record = find_or_initialize_by(key: key)
    record.value = value
    record.save!
  end

  # Commonly used configurations
  def self.site_title
    get("site_title", "Wedding RSVP")
  end

  def self.couple_names
    get("couple_names")
  end

  def self.primary_color
    get("primary_color", "#1f2937") # Default to gray-800
  end

  def self.highlight_color
    get("highlight_color", "#3b82f6") # Default to blue-500
  end
end
