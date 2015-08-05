source 'https://rubygems.org'
ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Compass for mixins
gem 'compass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use devise for user authentication and signup. Read more: https://github.com/plataformatec/devise
gem 'devise'
# Use wicked for multi-step wizard based application. Read more: https://github.com/schneems/wicked
gem 'wicked'
# Use simple_form to build form elements. Read more: https://github.com/plataformatec/simple_form
gem 'simple_form'
# Use paperclip for attachment uploads. Read more: https://github.com/thoughtbot/paperclip
gem "paperclip", "~> 4.2"
gem "aws-sdk"
# Use the requirejs gem to use require within rails
# gem 'requirejs-rails'
# Use unicorn as the app server
gem 'unicorn'
# Use airbrake for error reporting
gem "airbrake"
# Use gibbon for interaction with Mailchimp lists
gem "gibbon"
# Encode email addresses
gem "actionview-encoded_mail_to"
# Grouping: Goes hand in hand with Chartkick
gem "groupdate"
# Used by the admin dashboard
gem "chartkick"
# Bootstrap css
gem 'bootstrap-sass', '~> 3.2.0'
# Recommended for Bootstrap
gem 'autoprefixer-rails'
# Bootstrap form element helper
gem 'bootstrap_form'
# JQuery Data Tables
gem 'jquery-datatables-rails', '~> 3.1.1'
gem 'ajax-datatables-rails'
# Used to migrate data with a rake db:migrate task
gem 'migration_data'
# Awesome fonts...
gem "font-awesome-rails"
# https://github.com/daneden/animate.css
gem "animate-rails"
# Builds the admin navigation from a config file
gem "simple-navigation", '~> 3.14.0'
# Multi-select fields
gem 'chosen-sass-bootstrap-rails'
# Custom date picker based on Bootstrap.
gem 'bootstrap-datepicker-rails'
# jQuery cookies
gem 'jquery-cookie-rails'
# Workflow - https://github.com/geekq/workflow
gem 'workflow'
# Audit changes to ActiveRecord records.
gem "audited-activerecord", "~> 4.0"
# Queue
gem 'delayed_job_active_record'
gem 'delayed_job_web'
# Does what is says.  Mandrill API integration for sending email using templates maintained in mandrill and mail chimp.
gem 'mandrill-api', require: 'mandrill'
# Pagination
gem 'kaminari'
# Timeout troubleshooting
gem "rack-timeout"

group :production do 
	# Use Heroku deployment
	gem 'rails_12factor'
	gem 'font_assets'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'quiet_assets'
  gem 'launchy'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'mocha'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.2.0'
  gem 'rspec-its', '~> 1.1.0'
end

gem 'newrelic_rpm'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

