require 'rails'
require 'time'

class UnityServer < ActiveRecord::Base
  def self.import_server_info
    server_info = AllscriptsIntegration.get_unity_server_info
    server_info_hash = JSON[server_info][0]["getserverinfoinfo"][0]
    new_server_info = UnityServer.new

    # Pull out the timezone offset
    # Original timezone looks like this: "2014-05-14T16:48:13.0180000-04:00"
    # Supposed to output something like -4
    new_server_info.server_date_time_offset = server_info_hash["ServerDateTimeOffset"].to_time.strftime("%z")
      #strftime("%z")
    new_server_info.server_time = server_info_hash["ServerTime"]
    new_server_info.uai_born_on_date = Date.strptime(server_info_hash["uaibornondate"], "%m/%d/%Y")
    new_server_info.product_version = server_info_hash["ProductVersion"]
    new_server_info.system = server_info_hash["System"]
    new_server_info.server_time_zone = server_info_hash["ServerTimeZone"]

    new_server_info.save
  end
end
