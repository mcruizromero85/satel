source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.9'
gem 'eventmachine', '~>1.0.4'
gem 'thin'
gem 'websocket-rails'
gem 'faye-websocket', '0.10.0'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'



group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

#gem "less-rails"

group :production, :staging do
      gem 'pg'
      gem 'rails_12factor'
end

gem 'newrelic_rpm'

group :development, :test do
  gem 'rspec-rails'
  gem "factory_girl_rails", "~> 4.0"
  gem 'database_cleaner', '~> 1.3.0'
  gem 'simplecov', :require => false
  gem 'rubocop', '~> 0.45.0', require: false
  gem 'tilt'
  gem 'coffee-rails-source-maps'
  gem 'capybara'
  gem 'rb-readline'
end
gem 'omniauth'
gem 'omniauth-facebook'
gem 'foreigner'
gem 'paypal-sdk-rest'
gem "font-awesome-rails"
