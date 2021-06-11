class MailGroupsController < ApplicationController
  before_action :set_mail_group, only: [:show, :edit, :update, :destroy]
  before_action :check_level, only: [:new]
  #load_and_authorize_resource
  #before_action :load_permissions

  # GET /mail_groups
  # GET /mail_groups.json
  def index
    @mail_groups = MailGroup.where(company_id: current_user.client_id)
  end

  # GET /mail_groups/1
  # GET /mail_groups/1.json
  def show
    @emails = @mail_group.emails
  end

  # GET /mail_groups/new
  def new
    @mail_group = MailGroup.new
    @emails = Email.where(company_id: current_user.client_id).compact
    @role_permissions = @mail_group.emails.collect{|p| p.id}
  end

  # GET /mail_groups/1/edit
  def edit
    @emails = Email.where(company_id: current_user.client_id).compact
    @role_permissions = @mail_group.emails.collect{|p| p.id}
  end

  # POST /mail_groups
  # POST /mail_groups.json
  def create
    @emails = Email.where(company_id: current_user.client_id).compact
    @mail_group = MailGroup.new(mail_group_params)
    @mail_group.emails = []
    @mail_group.set_emails(params[:emails]) if params[:emails]

    respond_to do |format|
      if @mail_group.save
        format.html { redirect_to @mail_group, notice: 'Mail group was successfully created.' }
        format.json { render :show, status: :created, location: @mail_group }
      else
        format.html { render :new }
        format.json { render json: @mail_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_groups/1
  # PATCH/PUT /mail_groups/1.json
  def update
    @emails = Email.where(company_id: current_user.client_id).compact
    @mail_group.emails = []
    @mail_group.set_emails(params[:emails]) if params[:emails]

    respond_to do |format|
      if @mail_group.update(mail_group_params)
        format.html { redirect_to @mail_group, notice: 'Mail group was successfully updated.' }
        format.json { render :show, status: :ok, location: @mail_group }
      else
        format.html { render :edit }
        format.json { render json: @mail_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_groups/1
  # DELETE /mail_groups/1.json
  def destroy
    @mail_group.destroy
    respond_to do |format|
      format.html { redirect_to mail_groups_url, notice: 'Mail group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_group
      @mail_group = MailGroup.find(params[:id])
      if @mail_group.company_id != current_user.client_id
        respond_to do |format|
          format.html { redirect_to mail_groups_path, alert: 'Sorry! You do not have permissions to view this.' }
        end
      end
    end

    def check_level
      the_num = MailGroup.where(company_id: current_user.client_id).count()
      payment_id = ClientInfo.where(id: current_user.client_id).pluck(:payment_type)[0]
      the_set_count = PaymentType.where(id: payment_id).pluck(:email_book)[0]
      if the_set_count <= the_num
        respond_to do |format|
          format.html { redirect_to mail_groups_path, alert: 'Sorry! You have exhausted your allowance, please upgrade your package.' }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_group_params
      params.require(:mail_group).permit(:name, :description, :status, :company_id, :user_id, :emails => [])
    end
end
