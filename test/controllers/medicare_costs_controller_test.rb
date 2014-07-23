require 'test_helper'

class MedicareCostsControllerTest < ActionController::TestCase
  setup do
    @medicare_cost = medicare_costs(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:medicare_costs)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create medicare_cost' do
    assert_difference('MedicareCost.count') do
      post :create, medicare_cost: { address_line_1: @medicare_cost.address_line_1, address_line_2: @medicare_cost.address_line_2, average_medicare_allowed_amount: @medicare_cost.average_medicare_allowed_amount, average_medicare_payment_amount: @medicare_cost.average_medicare_payment_amount, average_submitted_charge_amount: @medicare_cost.average_submitted_charge_amount, beneficiaries_count: @medicare_cost.beneficiaries_count, city: @medicare_cost.city, country: @medicare_cost.country, credentials: @medicare_cost.credentials, distinct_services_per_beneficiary_count: @medicare_cost.distinct_services_per_beneficiary_count, entity_code: @medicare_cost.entity_code, first_name: @medicare_cost.first_name, gender: @medicare_cost.gender, hcpcs_description: @medicare_cost.hcpcs_description, hcps_code: @medicare_cost.hcps_code, last_name: @medicare_cost.last_name, medicare_participation_indicator: @medicare_cost.medicare_participation_indicator, mi: @medicare_cost.mi, npi: @medicare_cost.npi, place_of_service: @medicare_cost.place_of_service, provider_type: @medicare_cost.provider_type, services_provided_count: @medicare_cost.services_provided_count, state: @medicare_cost.state, stdev_medicare_allowed_amount: @medicare_cost.stdev_medicare_allowed_amount, stdev_medicare_payment_amount: @medicare_cost.stdev_medicare_payment_amount, stdev_submitted_charge_amount: @medicare_cost.stdev_submitted_charge_amount, zip: @medicare_cost.zip }
    end

    assert_redirected_to medicare_cost_path(assigns(:medicare_cost))
  end

  test 'should show medicare_cost' do
    get :show, id: @medicare_cost
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @medicare_cost
    assert_response :success
  end

  test 'should update medicare_cost' do
    patch :update, id: @medicare_cost, medicare_cost: { address_line_1: @medicare_cost.address_line_1, address_line_2: @medicare_cost.address_line_2, average_medicare_allowed_amount: @medicare_cost.average_medicare_allowed_amount, average_medicare_payment_amount: @medicare_cost.average_medicare_payment_amount, average_submitted_charge_amount: @medicare_cost.average_submitted_charge_amount, beneficiaries_count: @medicare_cost.beneficiaries_count, city: @medicare_cost.city, country: @medicare_cost.country, credentials: @medicare_cost.credentials, distinct_services_per_beneficiary_count: @medicare_cost.distinct_services_per_beneficiary_count, entity_code: @medicare_cost.entity_code, first_name: @medicare_cost.first_name, gender: @medicare_cost.gender, hcpcs_description: @medicare_cost.hcpcs_description, hcps_code: @medicare_cost.hcps_code, last_name: @medicare_cost.last_name, medicare_participation_indicator: @medicare_cost.medicare_participation_indicator, mi: @medicare_cost.mi, npi: @medicare_cost.npi, place_of_service: @medicare_cost.place_of_service, provider_type: @medicare_cost.provider_type, services_provided_count: @medicare_cost.services_provided_count, state: @medicare_cost.state, stdev_medicare_allowed_amount: @medicare_cost.stdev_medicare_allowed_amount, stdev_medicare_payment_amount: @medicare_cost.stdev_medicare_payment_amount, stdev_submitted_charge_amount: @medicare_cost.stdev_submitted_charge_amount, zip: @medicare_cost.zip }
    assert_redirected_to medicare_cost_path(assigns(:medicare_cost))
  end

  test 'should destroy medicare_cost' do
    assert_difference('MedicareCost.count', -1) do
      delete :destroy, id: @medicare_cost
    end

    assert_redirected_to medicare_costs_path
  end
end
