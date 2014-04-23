# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Additiveanalytics::Application.initialize!

ALLSCRIPTS_CONFIG = YAML.load_file("#{RAils.root}/config/allscripts.yml")[Rails.env] rescue {}
