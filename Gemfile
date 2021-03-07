# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "bridgetown", ENV["BRIDGETOWN_VERSION"] if ENV["BRIDGETOWN_VERSION"]

group :development, :test do
  gem "rake", "~> 13.0"
  gem "standard", "~> 1.0"
  gem "solargraph", "~> 0.39"
end

group :test do
  gem "rspec", "~> 3.0"
  gem "coveralls", "~> 0.8.23"
  gem "simplecov", "~> 0.16.1"
end
