require 'rails'

class PatientAppointment < ActiveRecord::Base
  belongs_to :patient, foreign_key: 'patient_id'

  validates_uniqueness_of :appointment_id 

  # Don't save empty strings. Store them as null values in the db.
  nilify_blanks

  def self.import_immunizations
    Patient.all.each do |p|
      import_immunization(p.patient_id)
    end
  end

  def self.import_patient_appointments
    appointment = AllscriptsIntegration.get_patient_appointment('demo', '1970-01-01')
    unless JSON[immunization][0]['getappointmentsbychangedttminfo'][0].nil?
      new_appointment_hash = JSON[immunization][0]['getappointmentsbychangedttminfo'][0]
      new_appointment = PatientAppointment.new

      new_appointment.appointment_id = new_apointment_hash['Appointment_ID']

      new_appointment.save
    end
  end
end

