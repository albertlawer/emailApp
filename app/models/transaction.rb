class Transaction < ActiveRecord::Base
	belongs_to :a_client, class_name: "ClientInfo", foreign_key: :company_id
	belongs_to :a_user, class_name: "User", foreign_key: :user_id
	belongs_to :an_email, class_name: "Email", foreign_key: :email_id
	belongs_to :a_mail_master, class_name: "MailMaster", foreign_key: :request_master_id
end
