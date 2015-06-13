ruby "2.1.5"

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# Use postgre as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
#gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Gema para que no haya problemas entre jQuery y Turbolinks
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Foundation Framework
gem 'foundation-rails'

# Use Devise authentication rails engine
gem 'devise'

#Adds group and membership functionality to Rails models.
gem 'groupify'

# Easy file attachment library for Active Record
gem "paperclip", "~> 4.2"
# Using Dropbox as paperclip storage
gem "paperclip-dropbox", ">= 1.1.7"

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

  gem 'lazy_high_charts'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Behaviour-Driven Development (BDD) tool for Ruby programmers
  gem 'rspec-rails', '~> 3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Add a comment summarizing the current schema to the top or bottom of each of your
  gem 'annotate', '~> 2.6.6'

  # Easily generate a diagram based on your application's Active Record models
  gem 'rails-erd'
  
end

group :production do
  gem 'rails_12factor'
end
