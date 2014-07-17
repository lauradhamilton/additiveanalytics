require 'builder'
include ActionView::Helpers::NumberHelper

class ImmunizationTrackerController < ApplicationController

  before_action :authenticate_user!

  def list
  end

  def influenza

    # Generate an HTML table w/ patients needing influenza vaccines
    @result = Patient.find_patients_needing_influenza_shots
    data = []
    @result.each do |row|
      # Display the phone numbers all pretty, with hyphens
      row["phone_number"] = number_to_phone(row["phone_number"], area_code: true)
      row["work_phone"]= number_to_phone(row["work_phone"], area_code: true)
      row["cell_phone"] = number_to_phone(row["cell_phone"], area_code: true)
      data << row
    end
    headers = ["Patient ID", "Gender", "First", "Last", "Email", "Home Phone", "Work Phone", "Cell Phone"]
    cells = data.map do |data|
      "<tr><td>#{data.values.join('</td><td>')}</td></tr>"
    end.join("\n ")
    table = %{<table class="table table-striped">
      <tr><th>#{headers.join('</th><th>')}</th></tr>
      #{cells}</table>}
    @display_patients_needing_influenza_shots = table
  end
end
