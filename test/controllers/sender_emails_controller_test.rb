require 'test_helper'

class SenderEmailsControllerTest < ActionController::TestCase
  setup do
    @sender_email = sender_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sender_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sender_email" do
    assert_difference('SenderEmail.count') do
      post :create, sender_email: { authentication: @sender_email.authentication, company_id: @sender_email.company_id, email_address: @sender_email.email_address, email_password: @sender_email.email_password, email_port: @sender_email.email_port, email_username: @sender_email.email_username, name: @sender_email.name, status: @sender_email.status, user_id: @sender_email.user_id }
    end

    assert_redirected_to sender_email_path(assigns(:sender_email))
  end

  test "should show sender_email" do
    get :show, id: @sender_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sender_email
    assert_response :success
  end

  test "should update sender_email" do
    patch :update, id: @sender_email, sender_email: { authentication: @sender_email.authentication, company_id: @sender_email.company_id, email_address: @sender_email.email_address, email_password: @sender_email.email_password, email_port: @sender_email.email_port, email_username: @sender_email.email_username, name: @sender_email.name, status: @sender_email.status, user_id: @sender_email.user_id }
    assert_redirected_to sender_email_path(assigns(:sender_email))
  end

  test "should destroy sender_email" do
    assert_difference('SenderEmail.count', -1) do
      delete :destroy, id: @sender_email
    end

    assert_redirected_to sender_emails_path
  end
end
