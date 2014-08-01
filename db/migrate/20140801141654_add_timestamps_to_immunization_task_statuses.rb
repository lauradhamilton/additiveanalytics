class AddTimestampsToImmunizationTaskStatuses < ActiveRecord::Migration
  def self.up
    add_column(:immunization_task_statuses, :created_at, :datetime)
    add_column(:immunization_task_statuses, :updated_at, :datetime)
  end

  def self.down
    remove_column(:immunization_task_statuses, :created_at)
    remove_column(:immunization_task_statuses, :updated_at)
  end
end
