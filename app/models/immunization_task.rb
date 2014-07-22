require 'rails'

class ImmunizationTask < ActiveRecord::Base

  belongs_to :patient, :foreign_key => "patient_id"

  validates_uniqueness_of :immunization, scope: [:patient_id]

  def self.create_zoster_tasks
    zoster_patients = Patient.find_patients_needing_zoster_shots
    zoster_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'zoster'
      #unless ImmunizationTask.find_by_patient_id(patient_id)
      #  new_immunization_task.save
      #end
      new_immunization_task.save
    end
  end
end
