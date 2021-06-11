class EmailsMailGroupsController < ApplicationController
  before_action :set_emails_mail_group, only: [:show, :edit, :update, :destroy]

  # GET /emails_mail_groups
  # GET /emails_mail_groups.json
  def index
    @emails_mail_groups = EmailsMailGroup.all
  end

  # GET /emails_mail_groups/1
  # GET /emails_mail_groups/1.json
  def show
  end

  # GET /emails_mail_groups/new
  def new
    @emails_mail_group = EmailsMailGroup.new
  end

  # GET /emails_mail_groups/1/edit
  def edit
  end

  # POST /emails_mail_groups
  # POST /emails_mail_groups.json
  def create
    @emails_mail_group = EmailsMailGroup.new(emails_mail_group_params)

    respond_to do |format|
      if @emails_mail_group.save
        format.html { redirect_to @emails_mail_group, notice: 'Emails mail group was successfully created.' }
        format.json { render :show, status: :created, location: @emails_mail_group }
      else
        format.html { render :new }
        format.json { render json: @emails_mail_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails_mail_groups/1
  # PATCH/PUT /emails_mail_groups/1.json
  def update
    respond_to do |format|
      if @emails_mail_group.update(emails_mail_group_params)
        format.html { redirect_to @emails_mail_group, notice: 'Emails mail group was successfully updated.' }
        format.json { render :show, status: :ok, location: @emails_mail_group }
      else
        format.html { render :edit }
        format.json { render json: @emails_mail_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails_mail_groups/1
  # DELETE /emails_mail_groups/1.json
  def destroy
    @emails_mail_group.destroy
    respond_to do |format|
      format.html { redirect_to emails_mail_groups_url, notice: 'Emails mail group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emails_mail_group
      @emails_mail_group = EmailsMailGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emails_mail_group_params
      params.require(:emails_mail_group).permit(:email_id, :mail_group_id, :status, :company_id, :user_id)
    end
end
