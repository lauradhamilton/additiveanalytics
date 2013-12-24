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

# Use datatables to dynamically filter data
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
# jquery-datatables-rails depends on sass-rails
gem 'sass-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', :require =>  false
end

# Apparently heroku's asset plugins aren't working with Rails 4
# Source: http://stackoverflow.com/questions/15354539/heroku-does-not-compile-files-under-assets-piplines-in-rails-4
group :production do
  gem 'rails_12factor'
end

# Fonts
gem "font-awesome-rails"

# Serve up blog from EC2 server
# The original gem by jaswope is no longer being maintained
# So I am using this fork
gem "rack-reverse-proxy", :git => 'https://github.com/sportngin/rack-reverse-proxy.git', :require => "rack/reverse_proxy"
gem "rack-proxy", :git => 'https://github.com/tstmedia/rack-proxy.git'

# Want to be able to deploy easily to EC2
gem 'capistrano'
gem 'capistrano-ext'

# Use passenger / nginx as the web server
gem 'passenger'
gem 'nginx'
