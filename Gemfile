# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.8'

gem 'rails', '~> 7.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'dartsass-rails'
gem 'propshaft'
gem 'bootstrap', '~> 5.3'
gem 'jbuilder'
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webmock'
end

group :development do
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'bullet'
  gem 'rubocop', require: false
  gem 'rubocop-fjord', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'slim_lint'
end

gem 'discordrb', '~> 3.7'
gem 'dotenv-rails'
gem 'meta-tags'
gem 'net-smtp'
gem 'omniauth'
gem 'omniauth-discord'
gem 'omniauth-rails_csrf_protection'
gem 'rails-i18n'
gem 'slim-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
