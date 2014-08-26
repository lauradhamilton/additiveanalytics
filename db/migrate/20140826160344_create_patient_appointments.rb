class CreatePatientAppointments < ActiveRecord::Migration
  def self.up
    create_table :patient_appointments do |t|
      t.integer :appointment_id
      t.time :appointment_time
      t.integer :patient_id
      t.integer :duration
      t.string :status
      t.integer :encounter_number
      t.time :time_scheduled
      t.time :time_confirmed
      t.integer :scheduling_location_id
      t.string :scheduled_location_abbreviation
      t.string :scheduled_location_description
      t.integer :scheduling_department_id
      t.integer :resource_id
      t.integer :appointment_type_id
      t.string :appointment_type_abbreviation
      t.string :appointment_type_description
      t.string :patient_first_name
      t.string :patient_last_name
      t.integer :patient_number
      t.string :attending_first_name
      t.string :attending_last_name
      t.string :attending_suffix
      t.string :attending_abbreviation
    end
  end

  def self.down
    drop_table :patient_appointments
  end
end
