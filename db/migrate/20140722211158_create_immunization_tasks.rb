class CreateImmunizationTasks < ActiveRecord::Migration
  def self.up
    create_table :immunization_tasks do |t|
      t.integer :patient_id
      t.string :immunization

      t.timestamps
    end
  # Each immunization task (missing immunization) should be listed
  # Only once per patient
  add_index :immunization_tasks, [:patient_id, :immunization], :unique => true
  execute <<-SQL
    ALTER TABLE immunization_tasks
    ADD CONSTRAINT fk_immunization_tasks_patients
    FOREIGN KEY (patient_id)
    REFERENCES patients(patient_id)
  SQL
  end

  def self.down
    drop_table :immunization_tasks
  end
end
