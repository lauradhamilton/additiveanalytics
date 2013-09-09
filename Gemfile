source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.0'
gem 'pg'
gem 'less-rails-bootstrap'
gem 'therubyracer' #LESS needs this

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Apparently heroku's asset plugins aren't working with Rails 4
# Source: http://stackoverflow.com/questions/15354539/heroku-does-not-compile-files-under-assets-piplines-in-rails-4
group :production do
  gem 'rails_12factor'
end

#Heroku gems
gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
