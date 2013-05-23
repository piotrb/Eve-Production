source 'http://rubygems.org'
ruby "2.0.0"

gem 'rails', '~> 3.2.0'

gem "pg"
gem 'mysql2'

gem 'thin'
gem 'json'
gem 'jquery-rails'

gem "omniauth"
gem "omniauth-google-oauth2"
gem 'dalli'

group :assets do
  gem 'sass-rails'#, "~> 3.2.0"
  gem 'coffee-rails'#, "~> 3.2.0"
  gem 'uglifier'
end

group :development do
  gem 'annotate'
  gem 'unicorn'
end

group :production do
  gem 'exception_notification', :require => 'exception_notifier'
end

group :test, :development do
  gem "rspec-rails"#, "~> 2.6"
  gem "factory_girl_rails"
end
