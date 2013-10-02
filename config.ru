# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::ReverseProxy do
  reverse_proxy(/^\/blog(\/.*)$/,
    'http://54.221.218.10/blog$1',
    opts = {:preserve_host => true})
end

use Rack::ReverseProxy do
  reverse_proxy('/blog',
    'http://54.221.218.10/blog',
    opts = {:preserve_host => true})
end


run Rails.application
