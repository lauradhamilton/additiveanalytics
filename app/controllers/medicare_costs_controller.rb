class MedicareCostsController < ApplicationController
  before_action :set_medicare_cost, only: [:show, :edit, :update, :destroy]

  # GET /medicare_costs
  def index
    @medicare_costs = MedicareCost.all
  end

  # GET /medicare_costs/1
  def show
  end

  # GET /medicare_costs/new
  def new
    @medicare_cost = MedicareCost.new
  end

  # GET /medicare_costs/1/edit
  def edit
  end

  # POST /medicare_costs
  def create
    @medicare_cost = MedicareCost.new(medicare_cost_params)

    if @medicare_cost.save
      redirect_to @medicare_cost, notice: 'Medicare cost was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /medicare_costs/1
  def update
    if @medicare_cost.update(medicare_cost_params)
      redirect_to @medicare_cost, notice: 'Medicare cost was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /medicare_costs/1
  def destroy
    @medicare_cost.destroy
    redirect_to medicare_costs_url, notice: 'Medicare cost was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_medicare_cost
    @medicare_cost = MedicareCost.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def medicare_cost_params
    params.require(:medicare_cost).permit(:npi, :last_name, :first_name, :mi, :credentials, :gender, :entity_code, :address_line_1, :address_line_2, :city, :zip, :state, :country, :provider_type, :medicare_participation_indicator, :place_of_service, :hcps_code, :hcpcs_description, :services_provided_count, :beneficiaries_count, :distinct_services_per_beneficiary_count, :average_medicare_allowed_amount, :stdev_medicare_allowed_amount, :average_submitted_charge_amount, :stdev_submitted_charge_amount, :average_medicare_payment_amount, :stdev_medicare_payment_amount)
  end
end
