class CreateInfluenzas < ActiveRecord::Migration
  def self.up
    create_table :influenzas do |t|
      t.date :view_date, :null => false
      t.string :title, :null => false
      t.integer :daily_views, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :influenzas
  end
end
