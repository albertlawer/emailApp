class PaymentType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :users, presence: true, numericality: true
  validates :email_count, presence: true, numericality: true
  validates :email_book, presence: true, numericality: true
  validates :email_templates, presence: true, numericality: true
  validates :sender_email, presence: true, numericality: true
end
