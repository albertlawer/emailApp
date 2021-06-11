json.extract! mail_master, :id, :request_code, :email_type, :subject, :body_template_id, :schedule_time, :email_group, :sender_email_id, :company_id, :user_id, :status, :created_at, :updated_at
json.url mail_master_url(mail_master, format: :json)
