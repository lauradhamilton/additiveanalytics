require 'simple_token_authentication'

class ScheduleAppApiController < ActionController::API

  after_action :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "*"
  end

  skip_before_filter :verify_authenticity_token

  def index
    appointment_date = Date.strptime(params[:appointment_date], '%Y%m%d')
    attending_abbreviation = params[:attending_abbreviation]
    appointment_list = PatientAppointment.where("appointment_time >= ?", appointment_date).where("appointment_time <= ?", appointment_date).where("attending_abbreviation = ?", attending_abbreviation)
    render json: appointment_list
  end
end
