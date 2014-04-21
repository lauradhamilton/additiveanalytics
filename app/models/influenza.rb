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
      new_influenza = Influenza.new
      new_influenza.title = 'Influenza'
      new_influenza.view_date = date[0]
      new_influenza.daily_views = date[1]
      new_influenza.save
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
    Influenza.where(:view_date => 1.year.ago..Date.today).select([:view_date, :daily_views]).to_json
  end

end




