class ValidateUniquenessOfPageViewData < ActiveRecord::Migration
  def self.up
    # Each page title should be in the database
    # Only once per date
    add_index :influenzas, [:view_date, :title], :unique => true
  end
end
