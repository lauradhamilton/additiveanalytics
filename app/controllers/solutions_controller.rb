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

  def readmissions
    respond_to do |format|
      format.html
      format.json { render json: ReadmissionsDatatable.new(view_context) }
    end
  end

  def flu_tracker
  end

  def flu_tracker_data
    respond_to do |format|
      format.any {render :json => Influenza.convert_influenza_data_to_json.html_safe}
    end
  end

  def treatment_tracker
  end

  def reduce_readmissions
  end

  def compare_prices
  end

  def compare_prices_data
    respond_to do |format|
      format.any { render json: MedicareCostSummary.convert_medicare_cost_summary_to_json }
    end
  end

  def price_variances_by_state
  end

  def price_variances_by_state_data
    respond_to do |format|
      format.any { render json: PriceVariancesByState.convert_price_variance_data_to_json}
    end
  end

end
