class MailMaster < ActiveRecord::Base
  	belongs_to :a_sender, class_name: "SenderEmail", foreign_key: :sender_email_id
  	belongs_to :a_group, class_name: "MailGroup", foreign_key: :email_group
  	belongs_to :a_body, class_name: "Template", foreign_key: :body_template_id
	
	validates :email_type, presence: true
	validates :subject, presence: true
	validates :body_template_id, presence: true
	validates :email_group, presence: true
	validates :sender_email_id, presence: true
	validate :the_validator


	def self.GenCode
		time=Time.new
		randval=rand(99).to_s.center(2, rand(9).to_s)
		uniqid=""
		public_id = loop do
						uniqid=time.strftime("%y%m%d%L%S%H%M").to_s + randval.to_s
					break uniqid unless MailMaster.exists?(request_code: uniqid)
					end
		return uniqid
	end

	def the_validator
		if self.email_type == 2 #schedule
			if self.schedule_time.nil?
				errors.add(:schedule_time, "cannot be empty")
			end
		end
	end
end
