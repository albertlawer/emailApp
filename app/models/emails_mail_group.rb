class EmailsMailGroup < ActiveRecord::Base
	belongs_to :an_email, class_name: "Email", foreign_key: :email_id
end
