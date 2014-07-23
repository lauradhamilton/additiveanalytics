class ValidateUniquenessOfPageViewData < ActiveRecord::Migration
  def self.up
    # Each page title should be in the database
    # Only once per date
    add_index :influenzas, [:view_date, :title], unique: true
  end

  def self.down
    remove_index 'index_influenzas_on_view_date_and_title'
  end
end
