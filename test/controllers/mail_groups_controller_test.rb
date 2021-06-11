require 'test_helper'

class MailGroupsControllerTest < ActionController::TestCase
  setup do
    @mail_group = mail_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_group" do
    assert_difference('MailGroup.count') do
      post :create, mail_group: { company_id: @mail_group.company_id, description: @mail_group.description, name: @mail_group.name, status: @mail_group.status, user_id: @mail_group.user_id }
    end

    assert_redirected_to mail_group_path(assigns(:mail_group))
  end

  test "should show mail_group" do
    get :show, id: @mail_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_group
    assert_response :success
  end

  test "should update mail_group" do
    patch :update, id: @mail_group, mail_group: { company_id: @mail_group.company_id, description: @mail_group.description, name: @mail_group.name, status: @mail_group.status, user_id: @mail_group.user_id }
    assert_redirected_to mail_group_path(assigns(:mail_group))
  end

  test "should destroy mail_group" do
    assert_difference('MailGroup.count', -1) do
      delete :destroy, id: @mail_group
    end

    assert_redirected_to mail_groups_path
  end
end
