require 'builder'

class ImmunizationTrackerController < ApplicationController
  def list
  end

  def influenza

    # Generate an HTML table w/ patients needing influenza vaccines
    @result = Patient.find_patients_needing_influenza_shots
    data = []
    @result.each do |row|
      data << row
    end
    headers = ["Patient ID", "Gender", "First", "Last", "Email", "Home Phone", "Work Phone", "Cell Phone"]
    xm = Builder::XmlMarkup.new(:indent => 2)
    xm.table {
      #xm.tr { data[0].keys.each { |key| xm.th(key)}}
      xm.tr {headers.each { |header| xm.th(header)}}
      data.each { |row| xm.tr { row.values.each { |value| xm.td(value)}}}
    }
    @display_patients_needing_influenza_shots = xm
  end
end
