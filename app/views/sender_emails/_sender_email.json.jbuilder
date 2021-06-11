json.extract! sender_email, :id, :name, :email_username, :email_password, :email_address, :email_port, :authentication, :company_id, :user_id, :status, :created_at, :updated_at
json.url sender_email_url(sender_email, format: :json)
