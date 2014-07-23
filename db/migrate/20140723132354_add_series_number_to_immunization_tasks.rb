class AddSeriesNumberToImmunizationTasks < ActiveRecord::Migration
  def self.up
    add_column :immunization_tasks, :series_number, :integer
  end

  def self.down
    remove_column :immunization_tasks, :series_number
  end
end
