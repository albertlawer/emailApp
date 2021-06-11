require 'test_helper'

class EmailsMailGroupsControllerTest < ActionController::TestCase
  setup do
    @emails_mail_group = emails_mail_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emails_mail_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emails_mail_group" do
    assert_difference('EmailsMailGroup.count') do
      post :create, emails_mail_group: { company_id: @emails_mail_group.company_id, email_id: @emails_mail_group.email_id, mail_group_id: @emails_mail_group.mail_group_id, status: @emails_mail_group.status, user_id: @emails_mail_group.user_id }
    end

    assert_redirected_to emails_mail_group_path(assigns(:emails_mail_group))
  end

  test "should show emails_mail_group" do
    get :show, id: @emails_mail_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emails_mail_group
    assert_response :success
  end

  test "should update emails_mail_group" do
    patch :update, id: @emails_mail_group, emails_mail_group: { company_id: @emails_mail_group.company_id, email_id: @emails_mail_group.email_id, mail_group_id: @emails_mail_group.mail_group_id, status: @emails_mail_group.status, user_id: @emails_mail_group.user_id }
    assert_redirected_to emails_mail_group_path(assigns(:emails_mail_group))
  end

  test "should destroy emails_mail_group" do
    assert_difference('EmailsMailGroup.count', -1) do
      delete :destroy, id: @emails_mail_group
    end

    assert_redirected_to emails_mail_groups_path
  end
end
