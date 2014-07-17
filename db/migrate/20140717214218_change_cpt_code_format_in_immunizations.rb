class ChangeCptCodeFormatInImmunizations < ActiveRecord::Migration
  def self.up
    change_column :immunizations, :code, :string
  end

  def self.down
    change_column :immunizations, :code, :integer
  end
end
