

def pony_engine(from_mail, to_mail, body, address, port, username, password, auth, subject)
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

def pony_engine_attachment(from_mail, to_mail, body, address, port, username, password, auth, subject, _req_code)
    status = true
    begin
      _theAttchments = MailAttachment.where(request_code: _req_code)

      attachments = Hash.new

      _theAttchments.each do |an_attachment|
        attachments[an_attachment.attachment_name] = File.read("../../#{an_attachment.attachment_path}")
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




  def send_mail_engine(_sender_email,_email_group,_subject,_body,_company_id,_user_id,_request_code, mail_master_id)
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
        the_stat = pony_engine(from_mail, to_mail, body, address, port, username, password, auth, subject)
        Transaction.update(n.id, status: the_stat, updated_at: Time.now)
      else
        the_stat = pony_engine_attachment(from_mail, to_mail, body, address, port, username, password, auth, subject,_request_code)
        Transaction.update(n.id, status: the_stat, updated_at: Time.now)
      end
    end
  end





def run_schedule
	todayDate = Time.now
	@data = MailMaster.where("schedule_status is null and schedule_time is not null").order("schedule_time asc")

	@data.each do |mail_master|
		mail_master_id = mail_master.id
		_schedule_time = mail_master.schedule_time
	    _request_code = mail_master.request_code
	    _sender_email = mail_master.sender_email_id
	    _email_group = mail_master.email_group
	    _subject = mail_master.subject
	    _body = mail_master.a_body.body
	    _company_id = mail_master.company_id
	    _user_id = mail_master.user_id
	    status = ClientInfo.where(id: _company_id).pluck(:status)
	    

	    puts todayDate
	    puts _schedule_time



	    if status
	      	# Thread.new{
		      	# check if the time and date does not conflict
		      	if _schedule_time <= todayDate
		      		MailMaster.update(mail_master_id ,schedule_status: false)
		        	send_mail_engine(_sender_email,_email_group,_subject,_body,_company_id,_user_id,_request_code,mail_master_id)
		      		MailMaster.update(mail_master_id ,schedule_status: true)
		    	end
	      	# }
	    end
	end
end



