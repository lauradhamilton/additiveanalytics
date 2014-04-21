class CreateInfluenzas < ActiveRecord::Migration
  def self.up
    create_table :influenzas do |t|
      t.date :view_date
      t.string :title
      t.integer :daily_views

      t.timestamps
    end
  end

  def self.down
    drop_table :influenzas
  end
end
