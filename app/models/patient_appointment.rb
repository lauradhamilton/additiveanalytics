require 'rails'

class PatientAppointment < ActiveRecord::Base
  belongs_to :patient, foreign_key: 'patient_id'

  validates_uniqueness_of :appointment_id 

  # Don't save empty strings. Store them as null values in the db.
  nilify_blanks

  def self.import_patient_appointments
    appointment = AllscriptsIntegration.get_appointments_by_change_dttm('demo', '1970-01-01')
    JSON[appointment][0]['getappointmentsbychangedttminfo']
  end
end

