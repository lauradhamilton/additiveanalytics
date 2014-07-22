class AddPatientIdForeignKey < ActiveRecord::Migration
  def self.up
    # Patients.patient_id should be unique
    add_index :patients, :patient_id, :unique => true

    # Add immunizations.patient_id foriegn key
    execute <<-SQL
      ALTER TABLE immunizations
      ADD CONSTRAINT fk_immunizations_patients
      FOREIGN KEY (patient_id)
      REFERENCES patients(patient_id)
    SQL
  end

  def self.down
    execute <<-SQL
      ALTER TABLE immunizations
      DROP FOREIGN KEY fk_immunizations_patients
    SQL
  end
end


