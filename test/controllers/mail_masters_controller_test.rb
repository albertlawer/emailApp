require 'test_helper'

class MailMastersControllerTest < ActionController::TestCase
  setup do
    @mail_master = mail_masters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_masters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_master" do
    assert_difference('MailMaster.count') do
      post :create, mail_master: { body_template_id: @mail_master.body_template_id, company_id: @mail_master.company_id, email_group: @mail_master.email_group, email_type: @mail_master.email_type, request_code: @mail_master.request_code, schedule_time: @mail_master.schedule_time, sender_email_id: @mail_master.sender_email_id, status: @mail_master.status, subject: @mail_master.subject, user_id: @mail_master.user_id }
    end

    assert_redirected_to mail_master_path(assigns(:mail_master))
  end

  test "should show mail_master" do
    get :show, id: @mail_master
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_master
    assert_response :success
  end

  test "should update mail_master" do
    patch :update, id: @mail_master, mail_master: { body_template_id: @mail_master.body_template_id, company_id: @mail_master.company_id, email_group: @mail_master.email_group, email_type: @mail_master.email_type, request_code: @mail_master.request_code, schedule_time: @mail_master.schedule_time, sender_email_id: @mail_master.sender_email_id, status: @mail_master.status, subject: @mail_master.subject, user_id: @mail_master.user_id }
    assert_redirected_to mail_master_path(assigns(:mail_master))
  end

  test "should destroy mail_master" do
    assert_difference('MailMaster.count', -1) do
      delete :destroy, id: @mail_master
    end

    assert_redirected_to mail_masters_path
  end
end
