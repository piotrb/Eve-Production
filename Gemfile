source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

gem "pg"

gem 'thin'
gem 'json'
gem 'heroku'
gem 'jquery-rails'
gem "activerecord-import", :require => false

gem "omniauth"
gem 'dalli'

group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :development do
  gem 'annotate'
end

group :production do
  gem 'exception_notification', :require => 'exception_notifier'
end

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "factory_girl_rails"
end