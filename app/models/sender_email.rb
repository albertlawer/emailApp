class SenderEmail < ActiveRecord::Base
  belongs_to :a_client, class_name: "ClientInfo", foreign_key: :company_id

  validates :name, presence: true, uniqueness: { scope: :company_id, message: "Name already exists" }
  validates :email_username, presence: true
  validates :email_password, presence: true
  validates :email_address, presence: true
  validates :email_port, presence: true
  validates :authentication, presence: true


  def self.quickie(_data, _user_data)
    status = true
  	begin
  		Pony.mail({
	        :from => _data.email_username,
	        :to => _user_data.email,
	        :body => "Dear #{_user_data.first_name} #{_user_data.last_name}, \n\r\tEmail test successful!",
	        :via => :smtp,
	        :via_options => {
	          :address              => _data.email_address,
	          :port                 => _data.email_port,
	          :enable_starttls_auto => true,
	          :user_name            => _data.email_username,
	          :password             => _data.email_password,
	          :authentication       => _data.authentication.downcase,
	          :domain               => "localhost"
	        },
	        :subject => "Email Testing"
	      })
  	rescue 
  		status = false
  	end
  	return status
  end

  def self.pony_engine(from_mail, to_mail, body, address, port, username, password, auth, subject)
    status = true
    begin
      Pony.mail({
          :from => from_mail,
          :to => to_mail,
          :html_body => body,
          :via => :smtp,
          :via_options => {
            :address              => address,
            :port                 => port,
            :enable_starttls_auto => true,
            :user_name            => username,
            :password             => password,
            :authentication       => auth.downcase,
            :domain               => "localhost"
          },
          :subject => subject
        })
    rescue 
      status = false
    end
    return status
  end

  def self.pony_engine_attachment(from_mail, to_mail, body, address, port, username, password, auth, subject, _req_code)
    status = true
    begin
      _theAttchments = MailAttachment.where(request_code: _req_code)

      attachments = Hash.new

      _theAttchments.each do |an_attachment|
        attachments[an_attachment.attachment_name] = File.read("#{an_attachment.attachment_path}")
      end

      Pony.mail({
          :from => from_mail,
          :to => to_mail,
          :html_body => body,
          :via => :smtp,
          :via_options => {
            :address              => address,
            :port                 => port,
            :enable_starttls_auto => true,
            :user_name            => username,
            :password             => password,
            :authentication       => auth.downcase,
            :domain               => "localhost"
          },
          :subject => subject,
          :attachments => attachments
        })
    rescue 
      status = false
    end
    return status
  end


  def self.send_quick_mail_engine(_sender_email,_email_group,_subject,_body,_company_id,_user_id)
    _data = SenderEmail.find(_sender_email)
    from_mail =_data.email_username    
    address =  _data.email_address
    port = _data.email_port
    username = _data.email_username
    password = _data.email_password
    auth = _data.authentication


    
    @list = EmailsMailGroup.where(mail_group_id: _email_group)
    puts @list.count()


    @list.each do |an_email|
      @name = an_email.an_email.name
      @email = an_email.an_email.email
      @email_id = an_email.an_email.id
      @name = "" if @name.nil?
      subject = _subject
      body = _body

      subject = subject.gsub("**@email", @email) if subject.include? "**@email"
      subject = subject.gsub("**@name", @name) if subject.include? "**@name"
      body = body.gsub("**@email", @email) if body.include? "**@email"
      body = body.gsub("**@name", @name) if body.include? "**@name"

      to_mail = @email

      n = Transaction.new
      n.request_master_id = 0
      n.email_id = @email_id
      n.body_message = body
      n.user_id = _user_id
      n.company_id = _company_id
      n.created_at = Time.now
      n.subject = subject
      n.from_mail = from_mail

      n.save

      the_stat = self.pony_engine(from_mail, to_mail, body, address, port, username, password, auth, subject)
      Transaction.update(n.id, status: the_stat, updated_at: Time.now)
    end
  end


  def self.send_quick_mail(_data)
    # check if their lincence has not expired using their status
  
    _sender_email = _data[:sender_email_id]
    _email_group = _data[:email_group_id]
    _subject = _data[:subject]
    _body = _data[:body]
    _company_id = _data[:company_id]
    _user_id = _data[:user_id]
    status = ClientInfo.where(id: _company_id).pluck(:status)
    error_msg = 1 

    if status
      if _sender_email == nil || _email_group == nil || _subject == ""  || _body == "<p><br></p>"
        error_msg = 3 # fill in the select options
      else
        Thread.new{
          self.send_quick_mail_engine(_sender_email,_email_group,_subject,_body,_company_id,_user_id)
        }
      end
    else
      error_msg = 2 # client has been disabled
    end
    return error_msg
  end










  def self.send_instant_mail_engine(_sender_email,_email_group,_subject,_body,_company_id,_user_id,_request_code, mail_master_id)
    _data = SenderEmail.find(_sender_email)
    from_mail =_data.email_username    
    address =  _data.email_address
    port = _data.email_port
    username = _data.email_username
    password = _data.email_password
    auth = _data.authentication

    _attchment_count = MailAttachment.where(request_code: _request_code).count()

    
    @list = EmailsMailGroup.where(mail_group_id: _email_group)
    puts @list.count()


    @list.each do |an_email|
      @name = an_email.an_email.name
      @email = an_email.an_email.email
      @email_id = an_email.an_email.id
      @name = "" if @name.nil?
      subject = _subject
      body = _body

      subject = subject.gsub("**@email", @email) if subject.include? "**@email"
      subject = subject.gsub("**@name", @name) if subject.include? "**@name"
      body = body.gsub("**@email", @email) if body.include? "**@email"
      body = body.gsub("**@name", @name) if body.include? "**@name"

      to_mail = @email

      n = Transaction.new
      n.request_master_id = mail_master_id
      n.email_id = @email_id
      n.body_message = body
      n.user_id = _user_id
      n.company_id = _company_id
      n.created_at = Time.now
      n.subject = subject
      n.from_mail = from_mail

      n.save

      if _attchment_count == 0
        the_stat = self.pony_engine(from_mail, to_mail, body, address, port, username, password, auth, subject)
        Transaction.update(n.id, status: the_stat, updated_at: Time.now)
      else
        the_stat = self.pony_engine_attachment(from_mail, to_mail, body, address, port, username, password, auth, subject,_request_code)
        Transaction.update(n.id, status: the_stat, updated_at: Time.now)
      end
    end
  end






  def self.instant_mail(mail_master)
    #get all the required stuffs for sending mail
    mail_master_id = mail_master.id
    _request_code = mail_master.request_code
    _sender_email = mail_master.sender_email_id
    _email_group = mail_master.email_group
    _subject = mail_master.subject
    _body = mail_master.a_body.body
    _company_id = mail_master.company_id
    _user_id = mail_master.user_id
    status = ClientInfo.where(id: _company_id).pluck(:status)
    error_msg = 1 




    if status
      Thread.new{
        self.send_instant_mail_engine(_sender_email,_email_group,_subject,_body,_company_id,_user_id,_request_code,mail_master_id)
      }
    else
      error_msg = 2 # client has been disabled
    end


    




  end





end
