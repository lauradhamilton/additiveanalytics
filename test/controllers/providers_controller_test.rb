require 'test_helper'

class ProvidersControllerTest < ActionController::TestCase
  setup do
    @provider = providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provider" do
    assert_difference('Provider.count') do
      post :create, provider: { address_line_1: @provider.address_line_1, address_line_2: @provider.address_line_2, city: @provider.city, dea_number: @provider.dea_number, entry_code: @provider.entry_code, entry_pneumonic: @provider.entry_pneumonic, expiration_date: @provider.expiration_date, fax: @provider.fax, first_name: @provider.first_name, last_name: @provider.last_name, middle_name: @provider.middle_name, npi: @provider.npi, phone: @provider.phone, prefix_name: @provider.prefix_name, provider_is_inactive: @provider.provider_is_inactive, provider_key_ext: @provider.provider_key_ext, specialty: @provider.specialty, state: @provider.state, suffix_name: @provider.suffix_name, title_name: @provider.title_name }
    end

    assert_redirected_to provider_path(assigns(:provider))
  end

  test "should show provider" do
    get :show, id: @provider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provider
    assert_response :success
  end

  test "should update provider" do
    patch :update, id: @provider, provider: { address_line_1: @provider.address_line_1, address_line_2: @provider.address_line_2, city: @provider.city, dea_number: @provider.dea_number, entry_code: @provider.entry_code, entry_pneumonic: @provider.entry_pneumonic, expiration_date: @provider.expiration_date, fax: @provider.fax, first_name: @provider.first_name, last_name: @provider.last_name, middle_name: @provider.middle_name, npi: @provider.npi, phone: @provider.phone, prefix_name: @provider.prefix_name, provider_is_inactive: @provider.provider_is_inactive, provider_key_ext: @provider.provider_key_ext, specialty: @provider.specialty, state: @provider.state, suffix_name: @provider.suffix_name, title_name: @provider.title_name }
    assert_redirected_to provider_path(assigns(:provider))
  end

  test "should destroy provider" do
    assert_difference('Provider.count', -1) do
      delete :destroy, id: @provider
    end

    assert_redirected_to providers_path
  end
end
