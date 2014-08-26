require 'rails'

class PatientAppointment < ActiveRecord::Base
  belongs_to :patient, foreign_key: 'patient_id'

  validates_uniqueness_of :appointment_id 

  # Don't save empty strings. Store them as null values in the db.
  nilify_blanks

  def self.import_patient_appointments
    appointment = AllscriptsIntegration.get_appointments_by_change_dttm('demo', '1970-01-01')
    appointments_array = JSON[appointment][0]['getappointmentsbychangedttminfo']
    appointments_array.each do |a|
      new_appointment = PatientAppointment.new
      new_appointment.appointment_id = a['Appointment_ID']
      new_appointment.save
    end
  end
end

