require 'test_helper'

class PermissionsRolesControllerTest < ActionController::TestCase
  setup do
    @permissions_role = permissions_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:permissions_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create permissions_role" do
    assert_difference('PermissionsRole.count') do
      post :create, permissions_role: { permission_id: @permissions_role.permission_id, role_id: @permissions_role.role_id }
    end

    assert_redirected_to permissions_role_path(assigns(:permissions_role))
  end

  test "should show permissions_role" do
    get :show, id: @permissions_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @permissions_role
    assert_response :success
  end

  test "should update permissions_role" do
    patch :update, id: @permissions_role, permissions_role: { permission_id: @permissions_role.permission_id, role_id: @permissions_role.role_id }
    assert_redirected_to permissions_role_path(assigns(:permissions_role))
  end

  test "should destroy permissions_role" do
    assert_difference('PermissionsRole.count', -1) do
      delete :destroy, id: @permissions_role
    end

    assert_redirected_to permissions_roles_path
  end
end
