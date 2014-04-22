require 'uri'
require 'json'
require 'net/http'
require 'net/https'
require 'rails'

class Influenza < ActiveRecord::Base
  validates :title, uniqueness: {scope: :view_date,
    message: "Only one record per title per day" }

  def self.import_wikipedia_data(month)
    uri = URI.parse('http://stats.grok.se/json/en/' + month + '/Influenza')
    http = Net::HTTP.new(uri.host,uri.port)
    request = Net::HTTP::Get.new(uri.path, initheader = {'Content-Type' =>'application/json', 'User-Agent' => 'AdditiveAnalytics.com'})
    response = http.request(request)
    page_view_hash = JSON.parse(response.body)["daily_views"]

    # Extract the date and number of page views from json
    page_view_hash.each do |date|
      next if date[0].nil?
      next if date[1].nil?
      next if date[1] == 0 # Ignore dates with no page views -- bad data
      new_influenza = Influenza.new
      new_influenza.title = 'Influenza'
      new_influenza.view_date = date[0]
      new_influenza.daily_views = date[1]
      begin
        new_influenza.save
      rescue => e
      end
    end

  end

  def self.import_wikipedia_data_all_months
    start_date = '2007-12-01'.to_date
    number_of_months = (Date.today.year * 12 + Date.today.month) - (start_date.year*12 + start_date.month) + 1
    months = number_of_months.times.each_with_object([]) do |count, array|
      array << [(start_date.beginning_of_month + count.months).strftime("%Y%m")]
    end
    
    months.each do |month|
      import_wikipedia_data(month[0])
    end
  end

  def self.convert_influenza_data_to_json
    # Some days of the week are slower than others
    # Need to adjust for day of week to make the data smoother
    # Hardcoding the multipliers for now. Should probably be dynamic.
    weekday_multiplier_hash = {0 => 1.2676347595979661, 1 => 0.88774138257244348008, 2 => 0.86095675447288909424, 3 => 0.87132171349961786127, 4 => 0.89443209542822893529, 5 => 1.0458202024580044, 6 => 1.4160395293124987}
    influenza_hash = Influenza.where(:view_date => 3.years.ago..Date.today).select([:id, :view_date, :daily_views]).order('view_date ASC')
    influenza_hash.each do |i|
      i[:daily_views] = i[:daily_views] * weekday_multiplier_hash[i[:view_date].wday]
    end
    return influenza_hash.to_json
  end

end




