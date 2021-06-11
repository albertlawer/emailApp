require 'test_helper'

class MailAttachmentsControllerTest < ActionController::TestCase
  setup do
    @mail_attachment = mail_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_attachment" do
    assert_difference('MailAttachment.count') do
      post :create, mail_attachment: { attachment_name: @mail_attachment.attachment_name, attachment_path: @mail_attachment.attachment_path, request_code: @mail_attachment.request_code, status: @mail_attachment.status }
    end

    assert_redirected_to mail_attachment_path(assigns(:mail_attachment))
  end

  test "should show mail_attachment" do
    get :show, id: @mail_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_attachment
    assert_response :success
  end

  test "should update mail_attachment" do
    patch :update, id: @mail_attachment, mail_attachment: { attachment_name: @mail_attachment.attachment_name, attachment_path: @mail_attachment.attachment_path, request_code: @mail_attachment.request_code, status: @mail_attachment.status }
    assert_redirected_to mail_attachment_path(assigns(:mail_attachment))
  end

  test "should destroy mail_attachment" do
    assert_difference('MailAttachment.count', -1) do
      delete :destroy, id: @mail_attachment
    end

    assert_redirected_to mail_attachments_path
  end
end
