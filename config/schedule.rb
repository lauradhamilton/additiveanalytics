# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
set :path, Rails.root
set :output, Rails.root.join('log', 'cron.log')

# Import new Wikipedia data for the influenza tracker every day
every 1.day do
  runner 'Influenza.import_latest_wikipedia_data'
end

# Run a script to import Unity server data every day
every 1.day do
  runner 'UnityServer.import_server_info'
end

# Run a script to import the provider data every day
every 1.day do
  runner 'Provider.import_providers'
end

every 1.day do
  runner 'Patient.import_all_patients'
end

every 1.day do
  runner 'Immunization.import_immunizations'
end

every 1.day do
  runner 'ImmunizationTask.import_immunization_tasks'
end

every 1.hour do
  runner 'PatientAppointment.import_patient_appointments'
end
