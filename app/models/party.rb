class Party < ApplicationRecord
  validates :rsvp, inclusion: [true, false]

  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests
  validate :guests_preferences_are_present

  normalizes :notes, with: ->(notes) { notes.strip }

  normalizes :name, with: ->(name) { name.strip }
  before_validation :set_default_name, unless: :name?
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  before_validation :set_deadline
  validates :response_deadline, presence: true

  def locked?
    Date.today > response_deadline
  end

  private

  def set_default_name
    self.name ||= "#{guests.first.name}’s Party" if guests.first
  end

  def set_deadline
    self.response_deadline ||= Date.today.end_of_month
  end

  def guests_preferences_are_present
    return unless persisted?
    return unless rsvp

    guests.each do |guest|
      unless guest.food_preference.present?
        errors.add(:guests, "must all have chosen a feast")
      end

      unless guest.guild_id.present?
        errors.add(:guests, "must all have chosen a guild")
      end
    end
  end
end
