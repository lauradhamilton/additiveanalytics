class ScheduleAppApiController < ActionController::Base

  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :authenticate_user_from_token!

  after_action :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "*"
  end

  def index
    appointment_date = Date.strptime(params[:appointment_date], '%Y%m%d')
    attending_abbreviation = params[:attending_abbreviation]
    appointment_list = PatientAppointment.where("appointment_time >= ?", appointment_date).where("appointment_time < ?", appointment_date.next).where("attending_abbreviation = ?", attending_abbreviation)
    render json: appointment_list
    AuditLog.record_schedule_app_audit(current_user.id) # Make a record that the API was called
    # This is needed for HIPAA
  end
end
