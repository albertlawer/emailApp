require 'test_helper'

class ClientInfosControllerTest < ActionController::TestCase
  setup do
    @client_info = client_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_info" do
    assert_difference('ClientInfo.count') do
      post :create, client_info: { email: @client_info.email, expiry_date: @client_info.expiry_date, name: @client_info.name, payment_type: @client_info.payment_type, phone_one: @client_info.phone_one, phone_two: @client_info.phone_two, status: @client_info.status }
    end

    assert_redirected_to client_info_path(assigns(:client_info))
  end

  test "should show client_info" do
    get :show, id: @client_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_info
    assert_response :success
  end

  test "should update client_info" do
    patch :update, id: @client_info, client_info: { email: @client_info.email, expiry_date: @client_info.expiry_date, name: @client_info.name, payment_type: @client_info.payment_type, phone_one: @client_info.phone_one, phone_two: @client_info.phone_two, status: @client_info.status }
    assert_redirected_to client_info_path(assigns(:client_info))
  end

  test "should destroy client_info" do
    assert_difference('ClientInfo.count', -1) do
      delete :destroy, id: @client_info
    end

    assert_redirected_to client_infos_path
  end
end
