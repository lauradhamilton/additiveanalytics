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
      new_appointment.appointment_time = a['Appointment_DateTime']
      new_appointment.patient_id = a['Patient_ID']
      new_appointment.duration = a['Duration']
      new_appointment.status = a['Status']
      new_appointment.encounter_number = a['Encounter_Number']
      new_appointment.time_scheduled = a['DateTime_Scheduled']
      new_appointment.time_confirmed = a['DateTime_Confirmed']
      new_appointment.scheduling_location_id = a['Scheduling_Location_ID']
      new_appointment.scheduled_location_abbreviation = a['Appt_Sched_Location_Abbr']
      new_appointment.scheduled_location_description = a['Appt_Sched_Location_Desc']
      new_appointment.scheduling_department_id = a['Scheduling_Department_ID']
      new_appointment.resource_id = a['Resource_ID']
      new_appointment.appointment_type_id = a['Appointment_Type_ID']
      new_appointment.appointment_type_abbreviation = a['Appt_Type_Abbr']
      new_appointment.appointment_type_description = a['Appt_Type_Abbr']
      new_appointment.coverage_type = a['Coverage_Type']
      new_appointment.patient_first_name = a['Patient_First_Name']
      new_appointment.patient_last_name = a['Patient_Last_Name']
      new_appointment.patient_number = a['Patient_Number']
      new_appointment.attending_first_name = a['AttendingFirstName']
      new_appointment.attending_last_name = a['AttendingLastName']
      new_appointment.attending_suffix = a['AttendingSuffix']
      new_appointment.attending_abbreviation = a['AttendingAbbreviation']
      new_appointment.save
    end
  end
end

