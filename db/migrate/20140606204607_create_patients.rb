class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :age
      t.string :gender
      t.string :marital_status
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.string :occupation
      t.string :employer
      t.integer :phone_number, :limit => 8
      t.integer :work_phone, :limit => 8
      t.integer :cell_phone, :limit => 8
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.date   :date_of_birth
      t.integer :physician_phone, :limit => 8
      t.string :physician_first_name
      t.string :physician_last_name
      t.string :physician_username
      t.string :base64image
      t.string :primary_insurance
      t.string :language
      t.string :race
      t.string :ethnicity
      t.integer :patient_id, :limit => 8
      t.integer :ssn, :limit => 8
      t.string :mrn # Need to figure out what this is
      t.binary :picture_of_patient
      t.string :age_dec
      t.string :patient_location
    end
  end

  def self.down
    drop_table :patients
  end
end
