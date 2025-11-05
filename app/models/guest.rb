class Guest < ApplicationRecord
  include FoodPreference

  belongs_to :party
  belongs_to :group, optional: true
  has_and_belongs_to_many :mailings

  scope :attending, -> { joins(:party).where(parties: {rsvp: true}) }

  passwordless_with :email
  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email,
    uniqueness: {case_sensitive: false, allow_blank: true},
    format: {with: URI::MailTo::EMAIL_REGEXP, allow_blank: true}

  normalizes :name, with: ->(name) { name.strip }
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  # Notify all admin users
  def self.notify_admins(subject, body)
    Admin::Mailer.notify(subject, body).deliver_now
  end
end
