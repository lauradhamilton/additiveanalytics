class CreateImmunizations < ActiveRecord::Migration
  def self.up
    create_table :immunizations do |t|
      t.integer :patient_id
      t.integer :entry_code
      t.string :section
      t.string :status
      t.string :detail
      t.integer :code
      t.decimal :trans_id
      t.date :display_date
      t.string :description
    end
  end

  def self.down
    drop_table :immunizations
  end
end
