class MailMastersController < ApplicationController
  before_action :set_mail_master, only: [:show, :edit_draft, :update_draft, :push_mail]

  def drafts
    @mail_masters = MailMaster.where(company_id: current_user.client_id, status: true).order("created_at desc")
  end


  def sent_mails
    @mail_masters = MailMaster.where(company_id: current_user.client_id, status: false).order("created_at desc")
  end


  def send_mail
    @mail_master = MailMaster.new
    @sender_email = SenderEmail.where(company_id: current_user.client_id)
    @sender_email = @sender_email.map { |a|[a.name, a.id]  }
    @email_groups = MailGroup.where(company_id: current_user.client_id)
    @email_groups = @email_groups.map { |a|[a.name, a.id]  }
    @email_templates = Template.where(company_id: current_user.client_id)
    @email_templates = @email_templates.map { |a|[a.name, a.id]  }
    @email_types = [["Instant Mail",1],["Schedule Mail",2]]
  end


  def edit_draft
    if @mail_master.status != true #was not a draft msg
      respond_to do |format|
        format.html { redirect_to drafts_path, notice: 'This is not a draft anymore.' }
      end
    else
      @sender_email = SenderEmail.where(company_id: current_user.client_id)
      @sender_email = @sender_email.map { |a|[a.name, a.id]  }
      @email_groups = MailGroup.where(company_id: current_user.client_id)
      @email_groups = @email_groups.map { |a|[a.name, a.id]  }
      @email_templates = Template.where(company_id: current_user.client_id)
      @email_templates = @email_templates.map { |a|[a.name, a.id]  }
      @email_types = [["Instant Mail",1],["Schedule Mail",2]]
    end
  end


  def send_create
    if mail_master_params[:schedule_time] != ""
      _new_time = DateTime.strptime(mail_master_params[:schedule_time], '%d/%m/%Y %k:%M') 
      mail_master_params[:schedule_time] = _new_time
    end

    @mail_master = MailMaster.new(mail_master_params)
    @mail_master.request_code = MailMaster.GenCode

    @sender_email = SenderEmail.where(company_id: current_user.client_id)
    @sender_email = @sender_email.map { |a|[a.name, a.id]  }
    @email_groups = MailGroup.where(company_id: current_user.client_id)
    @email_groups = @email_groups.map { |a|[a.name, a.id]  }
    @email_templates = Template.where(company_id: current_user.client_id)
    @email_templates = @email_templates.map { |a|[a.name, a.id]  }
    @email_types = [["Instant Mail",1],["Schedule Mail",2]]

    if params[:commit] == "Save as Draft" #draft
      @mail_master.status = true
    else #sending mail
      @mail_master.status = false
    end

    respond_to do |format|
      if @mail_master.save

        #work on attachments
        if !params[:attachment_files].nil?
          uploaded_file = params[:attachment_files]
          file_path = "public/uploads/"+ uploaded_file.original_filename
          File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
            file.write(uploaded_file.read)
          end
          MailAttachment.create!(request_code: @mail_master.request_code, attachment_name: uploaded_file.original_filename, attachment_path: file_path, status: true)
        end

        if @mail_master.status == true
          format.html { redirect_to root_path, notice: 'Mail draft was successfully saved.' }
        else
          # now check if instant or scheduled
          if @mail_master.email_type == 1 # instant
            SenderEmail.instant_mail(@mail_master)
            format.html { redirect_to root_path, notice: 'Mail was successfully processed for sending.' }
          else
            format.html { redirect_to root_path, notice: 'Mail was successfully scheduled for sending.' }
          end
        end
      else
        format.html { render :send_mail }
      end
    end
  end


  def push_mail    
    respond_to do |format|
      if MailMaster.update(@mail_master.id, status: false)
        # now check if instant or scheduled
        if @mail_master.email_type == 1 # instant
          #peform instant mail fnc here
          SenderEmail.instant_mail(@mail_master)
          format.html { redirect_to root_path, notice: 'Mail was successfully processed for sending.' }
        else
          format.html { redirect_to root_path, notice: 'Mail was successfully scheduled for sending.' }
        end
      else
        format.html { redirect_to root_path, alert: 'Mail sending failed. Please try again.' }
      end
    end
  end



















  def update_draft
    if mail_master_params[:schedule_time] != ""
      _new_time = DateTime.strptime(mail_master_params[:schedule_time], '%d/%m/%Y %k:%M') 
      mail_master_params[:schedule_time] = _new_time
    end

    @sender_email = SenderEmail.where(company_id: current_user.client_id)
    @sender_email = @sender_email.map { |a|[a.name, a.id]  }
    @email_groups = MailGroup.where(company_id: current_user.client_id)
    @email_groups = @email_groups.map { |a|[a.name, a.id]  }
    @email_templates = Template.where(company_id: current_user.client_id)
    @email_templates = @email_templates.map { |a|[a.name, a.id]  }
    @email_types = [["Instant Mail",1],["Schedule Mail",2]]

    if params[:commit] == "Update Draft" #draft
      @mail_master.status = true
    else #sending mail
      @mail_master.status = false
    end
    
    respond_to do |format|
      if @mail_master.update(mail_master_params)

        #work on attachments
        if !params[:attachment_files].nil?
          uploaded_file = params[:attachment_files]
          file_path = "public/uploads/"+ uploaded_file.original_filename
          File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
            file.write(uploaded_file.read)
          end
          MailAttachment.create!(request_code: @mail_master.request_code, attachment_name: uploaded_file.original_filename, attachment_path: file_path, status: true)
        end

        if @mail_master.status == true
          format.html { redirect_to root_path, notice: 'Mail draft was successfully updated.' }
        else
          # now check if instant or scheduled
          if @mail_master.email_type == 1 # instant
            #peform instant mail fnc here
            SenderEmail.instant_mail(@mail_master)
            format.html { redirect_to root_path, notice: 'Mail was successfully processed for sending.' }
          else
            format.html { redirect_to root_path, notice: 'Mail was successfully scheduled for sending.' }
          end
        end
      else
        format.html { render :edit_draft }
      end
    end
  end




  



  # GET /mail_masters
  # GET /mail_masters.json
  
  # GET /mail_masters/1
  # GET /mail_masters/1.json
  def show
  end

  # GET /mail_masters/new
  def new
    @mail_master = MailMaster.new
  end

  # GET /mail_masters/1/edit
  def edit
  end

  # POST /mail_masters
  # POST /mail_masters.json
  def create
    @mail_master = MailMaster.new(mail_master_params)

    respond_to do |format|
      if @mail_master.save
        format.html { redirect_to @mail_master, notice: 'Mail master was successfully created.' }
        format.json { render :show, status: :created, location: @mail_master }
      else
        format.html { render :new }
        format.json { render json: @mail_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_masters/1
  # PATCH/PUT /mail_masters/1.json
  def update
    respond_to do |format|
      if @mail_master.update(mail_master_params)
        format.html { redirect_to @mail_master, notice: 'Mail master was successfully updated.' }
        format.json { render :show, status: :ok, location: @mail_master }
      else
        format.html { render :edit }
        format.json { render json: @mail_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_masters/1
  # DELETE /mail_masters/1.json
  def destroy
    @mail_master.destroy
    respond_to do |format|
      format.html { redirect_to mail_masters_url, notice: 'Mail master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_master
      @mail_master = MailMaster.find(params[:id])
      if @mail_master.company_id != current_user.client_id
        respond_to do |format|
          format.html { redirect_to mail_masters_path, alert: 'Sorry! You do not have permissions to view this.' }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_master_params
      params.require(:mail_master).permit(:request_code, :email_type, :subject, :body_template_id, :schedule_time, :email_group, :sender_email_id, :company_id, :user_id, :status)
    end
end
