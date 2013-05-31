source 'http://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.0.rc1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'less-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'less-rails-bootstrap'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# build json apis with ease. read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

gem 'bcrypt-ruby'

gem 'mysql2'

gem 'puma'
gem 'json'

gem 'haml-rails'

gem "omniauth"
gem "omniauth-google-oauth2"
gem 'dalli'

gem 'foreman'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  #gem 'unicorn'
end

group :production do
  #gem 'exception_notification', :require => 'exception_notifier'
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

group :test, :development do
  #gem "rspec-rails"#, "~> 2.6"
  #gem "factory_girl_rails"
end
