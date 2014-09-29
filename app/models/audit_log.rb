class AuditLog < ActiveRecord::Base
  belongs_to :user

  def self.record_schedule_app_audit(user_id)
    audit_log = AuditLog.new(
      :user_id => user_id,
      :description => 'Viewed patient schedule via smartphone app.')
    audit_log.save!
  end
end
