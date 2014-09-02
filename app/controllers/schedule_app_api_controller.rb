require 'simple_token_authentication'

class ScheduleAppApiController < ActionController::API
  before_action :authenticate_user!

  def index
    appointment_date = Date.strptime(params[:appointment_date], '%Y%m%d')
    attending_abbreviation = params[:attending_abbreviation]
    appointment_list = PatientAppointment.where("appointment_time >= ?", appointment_date).where("appointment_time <= ?", appointment_date).where("attending_abbreviation = ?", attending_abbreviation)
    render json: appointment_list
  end
end
