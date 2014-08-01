require 'builder'
require 'will_paginate'
include ActionView::Helpers::NumberHelper

class ImmunizationTasksController < ApplicationController
  before_action :authenticate_user!

  def list
  end

  def index
    @filterrific = Filterrific.new(ImmunizationTask, params[:filterrific])

    @filterrific.select_options = {
      sorted_by: ImmunizationTask.options_for_sorted_by,
      with_immunization: ImmunizationTask.options_for_select
    }

    @immunization_tasks = ImmunizationTask.filterrific_find(@filterrific).page(params[:page]).with_immunization_task_statuses

    respond_to do |format|
      format.html
      format.js
    end
  end

  def reset_filterrific
    # Clear session persistence
    session[:filterrific_immunization_tasks] = nil
    # Redirect back to the index action for default filter settings.
    redirect_to action: :index
  end
end
