class CreateUnityServers < ActiveRecord::Migration
  def change
    create_table :unity_servers do |t|
      t.string :server_time_zone
      t.timestamp :server_time
      t.timestamp :server_date_time_offset
      t.string :system
      t.string :product_version
      t.date :uai_born_on_date

      t.timestamps
    end
  end
end
