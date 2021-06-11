class SenderEmailsController < ApplicationController
  before_action :set_sender_email, only: [:show, :edit, :update, :destroy, :test_sender_email]
  before_action :check_level, only: [:new]
  #load_and_authorize_resource
  #before_action :load_permissions

  # GET /sender_emails
  # GET /sender_emails.json
  def index
    @sender_emails = SenderEmail.where(company_id: current_user.client_id)
  end

  def test_sender_email
    thestatus = SenderEmail.quickie(@sender_email, current_user)
    if thestatus
      respond_to do |format|
        format.html { redirect_to sender_emails_path, notice: 'You should receive a mail within 2 mins.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to sender_emails_path, alert: 'Error! You should check your parameters and update.' }
      end
    end
  end

  # GET /sender_emails/1
  # GET /sender_emails/1.json
  def show
  end

  # GET /sender_emails/new
  def new
    @sender_email = SenderEmail.new
    @auth = [["Plain","Plain"],["Login","Login"]]
  end

  # GET /sender_emails/1/edit
  def edit
    @auth = [["Plain","Plain"],["Login","Login"]]
  end

  # POST /sender_emails
  # POST /sender_emails.json
  def create
    @sender_email = SenderEmail.new(sender_email_params)
    @auth = [["Plain","Plain"],["Login","Login"]]

    respond_to do |format|
      if @sender_email.save
        format.html { redirect_to sender_emails_path, notice: 'Sender email was successfully created.' }
        format.json { render :show, status: :created, location: @sender_email }
      else
        format.html { render :new }
        format.json { render json: @sender_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sender_emails/1
  # PATCH/PUT /sender_emails/1.json
  def update
    @auth = [["Plain","Plain"],["Login","Login"]]
    respond_to do |format|
      if @sender_email.update(sender_email_params)
        format.html { redirect_to sender_emails_path, notice: 'Sender email was successfully updated.' }
        format.json { render :show, status: :ok, location: @sender_email }
      else
        format.html { render :edit }
        format.json { render json: @sender_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sender_emails/1
  # DELETE /sender_emails/1.json
  def destroy
    @sender_email.destroy
    respond_to do |format|
      format.html { redirect_to sender_emails_url, notice: 'Sender email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sender_email
      @sender_email = SenderEmail.find(params[:id])
      if @sender_email.company_id != current_user.client_id
        respond_to do |format|
          format.html { redirect_to sender_emails_path, alert: 'Sorry! You do not have permissions to view this.' }
        end
      end
    end

    def check_level
      the_num = SenderEmail.where(company_id: current_user.client_id).count()
      payment_id = ClientInfo.where(id: current_user.client_id).pluck(:payment_type)[0]
      the_set_count = PaymentType.where(id: payment_id).pluck(:sender_email)[0]
      if the_set_count <= the_num
        respond_to do |format|
          format.html { redirect_to sender_emails_path, alert: 'Sorry! You have exhausted your allowance, please upgrade your package.' }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sender_email_params
      params.require(:sender_email).permit(:name, :email_username, :email_password, :email_address, :email_port, :authentication, :company_id, :user_id, :status)
    end
end
