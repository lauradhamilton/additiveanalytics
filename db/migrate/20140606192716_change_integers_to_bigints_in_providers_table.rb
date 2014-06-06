class ChangeIntegersToBigintsInProvidersTable < ActiveRecord::Migration
  def change
    change_column :providers, :npi, :bigint
    change_column :providers, :phone, :bigint
    change_column :providers, :fax, :bigint
  end
end
