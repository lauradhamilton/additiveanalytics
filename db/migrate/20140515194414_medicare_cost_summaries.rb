class MedicareCostSummaries < ActiveRecord::Migration
  def self.up
    create_table :medicare_cost_summaries do |t|
      t.string :provider_name
      t.string :state
      t.string :procedure_type
      t.integer :procedures_count
      t.decimal :average_cost
    end
  end

  def self.down
    drop_table :medicare_cost_summaries
  end
end
