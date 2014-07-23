require 'test_helper'

class UnityServersControllerTest < ActionController::TestCase
  setup do
    @unity_server = unity_servers(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:unity_servers)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create unity_server' do
    assert_difference('UnityServer.count') do
      post :create, unity_server: { product_version: @unity_server.product_version, server_date_time_offset: @unity_server.server_date_time_offset, server_time: @unity_server.server_time, server_time_zone: @unity_server.server_time_zone, system: @unity_server.system, uai_born_on_date: @unity_server.uai_born_on_date }
    end

    assert_redirected_to unity_server_path(assigns(:unity_server))
  end

  test 'should show unity_server' do
    get :show, id: @unity_server
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @unity_server
    assert_response :success
  end

  test 'should update unity_server' do
    patch :update, id: @unity_server, unity_server: { product_version: @unity_server.product_version, server_date_time_offset: @unity_server.server_date_time_offset, server_time: @unity_server.server_time, server_time_zone: @unity_server.server_time_zone, system: @unity_server.system, uai_born_on_date: @unity_server.uai_born_on_date }
    assert_redirected_to unity_server_path(assigns(:unity_server))
  end

  test 'should destroy unity_server' do
    assert_difference('UnityServer.count', -1) do
      delete :destroy, id: @unity_server
    end

    assert_redirected_to unity_servers_path
  end
end
