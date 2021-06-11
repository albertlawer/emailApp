json.extract! client_info, :id, :name, :email, :phone_one, :phone_two, :payment_type, :expiry_date, :status, :created_at, :updated_at
json.url client_info_url(client_info, format: :json)
