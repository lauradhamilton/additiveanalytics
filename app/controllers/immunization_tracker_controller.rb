class ImmunizationTrackerController < ApplicationController
  def list
  end

  def influenza
    @result = Patient.find_patients_needing_influenza_shots
    @display_patients_needing_influenza_shots = []
    @result.each do |row|
      @display_patients_needing_influenza_shots << row
    end
  end
end
