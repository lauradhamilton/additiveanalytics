# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Additiveanalytics::Application.initialize!

ALLSCRIPTS_CONFIG = YAML.load_file("#{Rails.root}/config/allscripts.yml")
