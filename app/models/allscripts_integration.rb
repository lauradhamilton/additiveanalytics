require 'uri'
require 'json'
require 'net/http'
require 'net/https'
require 'rails'
require 'yaml'

class AllscriptsIntegration
  @@username = ALLSCRIPTS_CONFIG['username']
  @@password = ALLSCRIPTS_CONFIG['password']
  @@unity_service_url = ALLSCRIPTS_CONFIG['unity_service_url']
  @@appname = ALLSCRIPTS_CONFIG['appname']

  def self.get_security_token
    credentials_to_send = { 'Username' => @@username,
                            'Password' => @@password }.to_json
    uri = URI.parse(@@unity_service_url + '/GetToken')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = "#{credentials_to_send}"
    response = http.request(request)
    response.body
  end

  def self.get_unity_server_info
    uri = URI.parse(@@unity_service_url + '/MagicJson')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = { 'Action' => 'GetServerInfo',
                     'Appname' => @@appname,
                     'AppUserID' => '',
                     'PatientID' => '',
                     'Token' => AllscriptsIntegration.get_security_token,
                     'Parameter1' => '',
                     'Parameter2' => '',
                     'Parameter3' => '',
                     'Parameter4' => '',
                     'Parameter5' => '',
                     'Parameter6' => '',
                     'Data' => '' }.to_json
    puts request.body
    response = http.request(request)
    response.body
  end

  # Pulls up provider details
  def self.get_provider(provider_id)
    uri = URI.parse(@@unity_service_url + '/MagicJson')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = { 'Action' => 'GetProvider',
                     'Appname' => @@appname,
                     'AppUserID' => '',
                     'PatientID' => '',
                     'Token' => AllscriptsIntegration.get_security_token,
                     'Parameter1' => provider_id,
                     'Parameter2' => '',
                     'Parameter3' => '',
                     'Parameter4' => '',
                     'Parameter5' => '',
                     'Parameter6' => '',
                     'Data' => '' }.to_json
    puts request.body
    response = http.request(request)
    response.body
  end

  def self.search_patients(user_id, search_term)
    uri = URI.parse(@@unity_service_url + '/MagicJson')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = { 'Action' => 'SearchPatients',
                     'AppUserID' => user_id,
                     'Appname' => @@appname,
                     'PatientID' => '',
                     'Token' => AllscriptsIntegration.get_security_token,
                     'Parameter1' => search_term,
                     'Parameter2' => '',
                     'Parameter3' => '',
                     'Parameter4' => '',
                     'Parameter5' => '',
                     'Parameter6' => '',
                     'Data' => '' }.to_json
    puts request.body
    response = http.request(request)
    response.body
  end

  def self.get_changed_patients
    uri = URI.parse(@@unity_service_url + '/MagicJson')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = { 'Action' => 'GetChangedPatients',
                     'Appname' => @@appname,
                     'AppUserID' => '',
                     'PatientID' => '',
                     'Token' => AllscriptsIntegration.get_security_token,
                     'Parameter1' => '1986-01-01',
                     'Parameter2' => '',
                     'Parameter3' => '',
                     'Parameter4' => '',
                     'Parameter5' => '',
                     'Parameter6' => '',
                     'Data' => '' }.to_json
    puts request.body
    response = http.request(request)
    response.body
  end

  def self.get_immunizations(user_id, patient_id)
    uri = URI.parse(@@unity_service_url + '/MagicJson')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = { 'Action' => 'GetClinicalSummary',
                     'Appname' => @@appname,
                     'AppUserID' => user_id,
                     'PatientID' => patient_id,
                     'Token' => AllscriptsIntegration.get_security_token,
                     'Parameter1' => 'Immunizations',
                     'Parameter2' => '',
                     'Parameter3' => '',
                     'Parameter4' => '',
                     'Parameter5' => '',
                     'Parameter6' => '',
                     'Data' => '' }.to_json
    puts request.body
    response = http.request(request)
    response.body
  end

  # Pulls up basic (non-clinical) information about patient
  # Name, gender, birthdate, ssn, address, phone, email, insurance, etc.
  def self.get_patient(patient_id)
    uri = URI.parse(@@unity_service_url + '/MagicJson')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = { 'Action' => 'GetPatient',
                     'Appname' => @@appname,
                     'AppUserID' => '',
                     'PatientID' => patient_id,
                     'Token' => AllscriptsIntegration.get_security_token,
                     'Parameter1' => 'immunizations',
                     'Parameter2' => '',
                     'Parameter3' => '',
                     'Parameter4' => '',
                     'Parameter5' => '',
                     'Parameter6' => '',
                     'Data' => '' }.to_json
    puts request.body
    response = http.request(request)
    response.body
  end

  # Start of the Practice Management API
  def self.get_appointments_by_change_dttm(user_id, start_date)
    uri = URI.parse(@@unity_service_url + '/MagicJson')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = {'Action' => 'GetAppointmentsByChangeDTTM',
                    'Appname' => @@appname,
                    'AppUserID' => user_id,
                    'PatientID' => '',
                    'Token' => AllscriptsIntegration.get_security_token,
                    'Parameter1' => start_date,
                    'Parameter2' => '',
                    'Parameter3' => '',
                    'Parameter4' => '',
                    'Parameter5' => '',
                    'Parameter6' => '',
                    'Data' => '' }.to_json
    response = http.request(request)
    puts response.code
    response.body
  end
end
