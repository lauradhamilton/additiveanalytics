class SolutionsController < ApplicationController
  def list
  end

  def custom_analytics
  end

  def hospital_compare
  end

  def maternity
    respond_to do |format|
      format.html
      format.json { render json: MaternityDatatable.new(view_context) }
    end
  end
end
