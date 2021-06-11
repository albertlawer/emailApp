class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]
  before_action :check_level, only: [:new]
  #load_and_authorize_resource
  #before_action :load_permissions

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.where(company_id: current_user.client_id)
  end


  def email_upload
    @email = Email.new
  end


  def emails_import
    respond_to do |format|
      if params[:thefile].nil?
        format.html { redirect_to email_upload_path, alert: 'Please choose a CSV file.' }
      
      else                                              
        the_feed_back = Email.import_contacts(params[:thefile],current_user.client_id, current_user.id)

        puts "the feedback is #{the_feed_back}"




        if the_feed_back.to_i == 0
          format.html { redirect_to emails_path, notice: 'Emails were successfully Imported.' }

        elsif the_feed_back.to_i == 1
          format.html { redirect_to emails_path, notice: 'Emails were successfully imported with some issues.' }

        elsif the_feed_back.to_i == 2
          format.html { redirect_to email_upload_path, alert: 'Wrong file headers. Please download the sample csv file for the right headers' }

        elsif the_feed_back.to_i == 3
          format.html { redirect_to emails_path, alert: 'Sorry! You have exhausted your allowance, please upgrade your package.' }

        elsif the_feed_back.to_i == 4
          format.html { redirect_to emails_path, notice: 'Some emails were not able to be saved due to the fact you have reached your allocated usage! Please upgrade your package.' }
        end
      end
    end
  end


  def sample_csv
    send_file("#{Rails.root}/public/email_sample_csv.csv",filename: "email_sample_csv.csv",type: "application/csv")
  end


  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(email_params)

    respond_to do |format|
      if @email.save
        format.html { redirect_to emails_path, notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to emails_path, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
      if @email.company_id != current_user.client_id
        respond_to do |format|
          format.html { redirect_to emails_path, alert: 'Sorry! You do not have permissions to view this.' }
        end
      end
    end

    def check_level
      the_num = Email.where(company_id: current_user.client_id).count()
      payment_id = ClientInfo.where(id: current_user.client_id).pluck(:payment_type)[0]
      the_set_count = PaymentType.where(id: payment_id).pluck(:email_count)[0]
      if the_set_count <= the_num
        respond_to do |format|
          format.html { redirect_to emails_path, alert: 'Sorry! You have exhausted your allowance, please upgrade your package.' }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:name, :email, :status, :company_id, :user_id)
    end
end
