# source 'https://rubygems.org'

# gem 'rails', '3.2.2'

# # Bundle edge Rails instead:
# # gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'


# # Gems used only for assets and not required
# # in production environments by default.
# group :assets do
#   gem 'sass-rails',   '~> 3.2.3'
#   gem 'coffee-rails', '~> 3.2.1'

#   # See https://github.com/sstephenson/execjs#readme for more supported runtimes
#   # gem 'therubyracer'

#   gem 'uglifier', '>= 1.0.3'
# end

# gem 'jquery-rails'

# # To use ActiveModel has_secure_password
# # gem 'bcrypt-ruby', '~> 3.0.0'

# # To use Jbuilder templates for JSON
# # gem 'jbuilder'

# # Use unicorn as the app server
# # gem 'unicorn'

# # Deploy with Capistrano
# # gem 'capistrano'

# # To use debugger
# # gem 'ruby-debug19', :require => 'ruby-debug'

source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails', '4.0.2'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
end

gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '2.2.1'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

# Can't be in assets group
gem 'haml-rails'

gem 'phantomjs'
gem 'hpricot'
gem 'mysql2'
gem 'will_paginate', '~> 3.0'