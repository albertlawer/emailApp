class MailGroup < ActiveRecord::Base
	belongs_to :a_client, class_name: "ClientInfo", foreign_key: :company_id
  	has_and_belongs_to_many :emails
	validates :name, presence: true, uniqueness: { scope: :company_id, message: "Name already exists" }


	def set_emails(emails)
		emails.each do |id|
		  email = Email.find(id)
		  self.emails << email
		end
	end

	def self.count_mails(_id)
		return EmailsMailGroup.where(mail_group_id: _id).count()
	end
end
