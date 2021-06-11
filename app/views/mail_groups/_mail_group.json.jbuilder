json.extract! mail_group, :id, :name, :description, :status, :company_id, :user_id, :created_at, :updated_at
json.url mail_group_url(mail_group, format: :json)
