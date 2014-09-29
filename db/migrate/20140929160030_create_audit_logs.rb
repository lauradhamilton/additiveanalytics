class CreateAuditLogs < ActiveRecord::Migration
  def change
    create_table :audit_logs do |t|
      t.references :user, index: true
      t.string :description

      t.timestamps
    end
  end
end
