class ScheduleAppApiController < ActionController::API
  def index
    today_appointments = PatientAppointment.where("appointment_time >= ?", Date.today).where("appointment_time <= ?", Date.tomorrow)
    render json: today_appointments
  end
end
