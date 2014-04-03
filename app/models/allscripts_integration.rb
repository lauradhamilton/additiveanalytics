require 'uri'
require 'json'
require 'net/http'
require 'net/https'
require 'rails'

class AllscriptsIntegration
  @@username = 'AdditiveAnalytics'
  @@password = 'AdditiveAnalytics123!!'
  @@unity_service_url = "http://aws-pehr-13.unitysandbox.com/Unity/UnityService.svc/json"
  @@appname = 'AdditiveAnalytics.TestApp'

  def self.get_security_token
    credentials_to_send = {'Username' => @@username,
      'Password' => @@password}.to_json
    uri = URI.parse(@@unity_service_url + "/GetToken")
    http = Net::HTTP.new(uri.host,uri.port)
    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    request.body = "#{credentials_to_send}"
    response = http.request(request)
    return response.body
  end

  def self.get_unity_server_info
    uri = URI.parse(@@unity_service_url + "/MagicJson")
    http = Net::HTTP.new(uri.host,uri.port)
    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    request.body = {'Action' => 'GetServerInfo',
      'Appname' => @@appname,
      'AppUserID' => @@username,
      'PatientID' => '',
      'Token' => AllscriptsIntegration.get_security_token,
      'Parameter1' => '',
      'Parameter2' => '',
      'Parameter3' => '',
      'Parameter4' => '',
      'Parameter5' => '',
      'Parameter6' => '',
      'Data' => ''}.to_json
    puts request.body
    response = http.request(request)
    return response.body
  end
end