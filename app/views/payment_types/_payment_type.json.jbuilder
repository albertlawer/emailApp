json.extract! payment_type, :id, :name, :body, :users, :email_count, :email_book, :email_templates, :sender_email, :created_at, :updated_at
json.url payment_type_url(payment_type, format: :json)
