# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::ReverseProxy do
  reverse_proxy(/^\/blog(\/.*)$/,
    'http://ec2-107-22-0-151.compute-1.amazonaws.com/blog$1',
    opts = {:preserve_host => true})
end

use Rack::ReverseProxy do
  reverse_proxy('/blog',
    'http://ec2-107-22-0-151.compute-1.amazonaws.com/blog',
    opts = {:preserve_host => true})
end


run Rails.application
