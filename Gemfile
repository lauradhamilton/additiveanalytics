source 'https://rubygems.org'
ruby "2.1.0"

gem 'rails', '~> 4.0.3'
gem 'pg'
gem 'less-rails-bootstrap'
gem 'therubyracer' #LESS needs this

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use datatables to dynamically filter data
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
# jquery-datatables-rails depends on sass-rails
gem 'sass-rails'

# Use D3 for data visualizations
gem 'd3_rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', :require =>  false
end

# Fonts
gem "font-awesome-rails"

# When saving a model, don't save empty strings. Save null instead.
gem "nilify_blanks"

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

# Schedule tasks with whenever
gem 'whenever', :require => false

# Authentication & login
gem 'devise'

# Transactional emails
gem 'mandrill_mailer'
