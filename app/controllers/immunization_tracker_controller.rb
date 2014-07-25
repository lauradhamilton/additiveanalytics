require 'builder'
include ActionView::Helpers::NumberHelper

class ImmunizationTrackerController < ApplicationController
  before_action :authenticate_user!

  def list
  end

  def index
    @filterrific = Filterrific.new(ImmunizationTask, params[:filterrific])
    @immunization_tasks = ImmunizationTask.filterrific_find(@filterrific).page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
end
