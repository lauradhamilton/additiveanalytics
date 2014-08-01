class ImmunizationTaskStatusesController < ApplicationController

  def new
    @immunization_task_status = ImmunizationTaskStatus.new
  end

  def create
    @immunization_task_status = ImmunizationTaskStatus.new

    @immunization_task_status.immunization_task_id = params[:immunization_task_id]
    @immunization_task_status.user_id = current_user.id
    @immunization_task_status.status = "close"

    @immunization_task_status.save!
  end
end
