require 'uri'
require 'json'
require 'net/http'
require 'net/https'
require 'yaml'
require 'rails'

@toSend = {'Username' => 'AdditiveAnalytics',
  'Password' => 'AdditiveAnalytics123!!'
}.to_json

uri = URI.parse("http://eehr-11-2-a.unitysandbox.com/Unity/unityservice.svc/json/GetToken")
http = Net::HTTP.new(uri.host,uri.port)
request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
request.body = "#{@toSend}"
puts request.body
response = http.request(request)
puts "Response #{response.code} #{response.message}: #{response.body}"
