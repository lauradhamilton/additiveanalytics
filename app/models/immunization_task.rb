require 'rails'

class ImmunizationTask < ActiveRecord::Base

  belongs_to :patient, :foreign_key => "patient_id"

  validates_uniqueness_of :immunization, scope: [:patient_id]

  def self.create_all_immunization_tasks
    create_hepatitis_a_tasks
    create_influenza_tasks
    create_zoster_tasks
  end

  def self.create_hepatitis_a_tasks
    hepatitis_a_series_1_patients = Patient.find_patients_needing_first_hepatitis_a_shot
    hepatitis_a_series_1_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'hepatitis_a_series_1'
      unless ImmunizationTask.find_by_patient_id_and_immunization(new_immunization_task.patient_id, 'hepatitis_a_series_1')
        new_immunization_task.save
      end
    end

    hepatitis_a_series_2_patients = Patient.find_patients_needing_second_hepatitis_a_shot
    hepatitis_a_series_2_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'hepatitis_a_series_2'
      unless ImmunizationTask.find_by_patient_id_and_immunization(new_immunization_task.patient_id, 'hepatitis_a_series_2')
        new_immunization_task.save
      end
    end
  end

  def self.create_influenza_tasks
    influenza_patients = Patient.find_patients_needing_influenza_shots
    influenza_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'influenza'
      unless ImmunizationTask.find_by_patient_id_and_immunization(new_immunization_task.patient_id, 'influenza')
        new_immunization_task.save
      end
    end
  end

  def self.create_zoster_tasks
    zoster_patients = Patient.find_patients_needing_zoster_shots
    zoster_patients.each do |patient|
      new_immunization_task = ImmunizationTask.new
      new_immunization_task.patient_id = patient.patient_id
      new_immunization_task.immunization = 'zoster'
      unless ImmunizationTask.find_by_patient_id_and_immunization(new_immunization_task.patient_id, 'zoster')
        new_immunization_task.save
      end
    end
  end
end
