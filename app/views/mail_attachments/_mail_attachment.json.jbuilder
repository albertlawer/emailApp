json.extract! mail_attachment, :id, :request_code, :attachment_name, :attachment_path, :status, :created_at, :updated_at
json.url mail_attachment_url(mail_attachment, format: :json)
