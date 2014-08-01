class CreateImmunizationTaskStatuses < ActiveRecord::Migration
  def self.up
    create_table :immunization_task_statuses do |t|
      t.integer :immunization_task_id
      t.integer :status
      t.integer :user_id
    end
    execute <<-SQL
      ALTER TABLE immunization_task_statuses
        ADD CONSTRAINT fk_immunization_task_statuses_immunization_tasks
        FOREIGN KEY (immunization_task_id)
        REFERENCES immunization_tasks(id)
    SQL
    execute <<-SQL
      ALTER TABLE immunization_task_statuses
        ADD CONSTRAINT fk_immunization_task_statuses_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def self.down
    drop_table :immunization_task_statuses
  end
end
