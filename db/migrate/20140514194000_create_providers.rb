class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :suffix_name
      t.string :prefix_name
      t.string :title_name
      t.integer :entry_code
      t.string :entry_pneumonic
      t.string :provider_key_ext
      t.integer :npi
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.integer :phone
      t.integer :fax
      t.string :specialty
      t.boolean :provider_is_inactive
      t.date :expiration_date
      t.integer :dea_number

      t.timestamps
    end
  end
end
