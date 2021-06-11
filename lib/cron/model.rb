

configure :development,:production do
  ActiveRecord::Base.establish_connection(
    adapter:  "postgresql",
    host:     "localhost",
    username: "albert",
    password: "proverbs3:5",
    database: "mail_db"
  )
end



class MailMaster < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :a_sender, class_name: "SenderEmail", foreign_key: :sender_email_id
  belongs_to :a_group, class_name: "MailGroup", foreign_key: :email_group
  belongs_to :a_body, class_name: "Template", foreign_key: :body_template_id
end


class SenderEmail < ActiveRecord::Base
  self.primary_key = 'id'
end

class MailGroup < ActiveRecord::Base
  self.primary_key = 'id'
end

class Template < ActiveRecord::Base
  self.primary_key = 'id'
end

class MailAttachment < ActiveRecord::Base
  self.primary_key = 'id'
end

class EmailsMailGroup < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :an_email, class_name: "Email", foreign_key: :email_id
end

class Email < ActiveRecord::Base
  belongs_to :a_client, class_name: "ClientInfo", foreign_key: :company_id
end

class ClientInfo < ActiveRecord::Base
  belongs_to :a_type, class_name: "PaymentType", foreign_key: :payment_type
end

class Transaction < ActiveRecord::Base
end
