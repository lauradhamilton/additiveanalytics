require 'builder'

class ImmunizationTrackerController < ApplicationController

  before_action :authenticate_user!

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
    cells = data.map do |data|
      "<tr><td>#{data.values.join('</td><td>')}</td></tr>"
    end.join("\n ")
    table = %{<table style="border-spacing: 10px">
      <tr><th>#{headers.join('</th><th>')}</th></tr>
      #{cells}</table>}
    @display_patients_needing_influenza_shots = table
  end
end
