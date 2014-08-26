class ScheduleAppApiController < ActionController::API
  def index
    appointment_date = Date.strptime(params[:appointment_date], '%Y%m%d')
    appointment_list = PatientAppointment.where("appointment_time >= ?", appointment_date).where("appointment_time <= ?", appointment_date)
    render json: appointment_list
  end
end
