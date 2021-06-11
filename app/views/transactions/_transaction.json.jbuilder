json.extract! transaction, :id, :request_master_id, :email_id, :body_message, :status, :user_id, :company_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
