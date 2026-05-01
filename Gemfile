source "https://rubygems.org"

ruby "4.0.2"

gem "rails", "~> 8.1.3"
gem "sqlite3"
gem "puma"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bootsnap", require: false

# Authentication
gem "devise"
gem "omniauth"
gem "omniauth-rails_csrf_protection"
gem "omniauth-github"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-twitch"

# Utilities
gem "will_paginate"
gem "simple_calendar"
gem "redcarpet"

group :development, :test do
  gem "debug"
  gem "brakeman", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "minitest-spec-rails"
  gem "rails-controller-testing"
end
