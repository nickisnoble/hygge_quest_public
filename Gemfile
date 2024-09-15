source "https://rubygems.org"
ruby "3.2.2"

gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 2.1"

gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

gem "passwordless", "~> 1.2"
gem "sqlite3", "~> 1.4"
gem "aws-sdk-s3", require: false

group :production do
  gem "resend"
end

group :development, :test do
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
  gem "letter_opener"
  gem "rails_live_reload"
end

group :test do
  gem "capybara"
  gem "cuprite"
end

gem "geocoder", "~> 1.8"
