class ClientInfo < ActiveRecord::Base
  belongs_to :a_type, class_name: "PaymentType", foreign_key: :payment_type

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :phone_one, presence: true
  validates :payment_type, presence: true
  validates :expiry_date, presence: true
end
