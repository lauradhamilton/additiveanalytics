class CreateMedicareCosts < ActiveRecord::Migration
  def self.up
    create_table :medicare_costs do |t|
      t.integer :npi
      t.string :last_name
      t.string :first_name
      t.string :mi
      t.string :credentials
      t.string :gender
      t.string :entity_code
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :zip
      t.string :state
      t.string :country
      t.string :provider_type
      t.string :medicare_participation_indicator
      t.string :place_of_service
      t.string :hcpcs_code
      t.string :hcpcs_description
      t.float :services_provided_count
      t.integer :beneficiaries_count
      t.integer :distinct_services_per_beneficiary_count
      t.decimal :average_medicare_allowed_amount, :precision => 8, :scale => 2
      t.decimal :stdev_medicare_allowed_amount, :precision => 8, :scale => 2
      t.decimal :average_submitted_charge_amount, :precision => 8, :scale => 2
      t.decimal :stdev_submitted_charge_amount, :precision => 8, :scale => 2
      t.decimal :average_medicare_payment_amount, :precision => 8, :scale => 2
      t.decimal :stdev_medicare_payment_amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :medicare_costs
  end
end
