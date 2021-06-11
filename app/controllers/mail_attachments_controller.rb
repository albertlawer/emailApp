class MailAttachmentsController < ApplicationController
  before_action :set_mail_attachment, only: [:show, :edit, :update, :destroy]

  # GET /mail_attachments
  # GET /mail_attachments.json
  def index
    @mail_attachments = MailAttachment.all
  end

  # GET /mail_attachments/1
  # GET /mail_attachments/1.json
  def show
  end

  # GET /mail_attachments/new
  def new
    @mail_attachment = MailAttachment.new
  end

  # GET /mail_attachments/1/edit
  def edit
  end

  # POST /mail_attachments
  # POST /mail_attachments.json
  def create
    @mail_attachment = MailAttachment.new(mail_attachment_params)

    respond_to do |format|
      if @mail_attachment.save
        format.html { redirect_to @mail_attachment, notice: 'Mail attachment was successfully created.' }
        format.json { render :show, status: :created, location: @mail_attachment }
      else
        format.html { render :new }
        format.json { render json: @mail_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_attachments/1
  # PATCH/PUT /mail_attachments/1.json
  def update
    respond_to do |format|
      if @mail_attachment.update(mail_attachment_params)
        format.html { redirect_to @mail_attachment, notice: 'Mail attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @mail_attachment }
      else
        format.html { render :edit }
        format.json { render json: @mail_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_attachments/1
  # DELETE /mail_attachments/1.json
  def destroy
    @mail_attachment.destroy
    respond_to do |format|
      format.html { redirect_to mail_attachments_url, notice: 'Mail attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_attachment
      @mail_attachment = MailAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_attachment_params
      params.require(:mail_attachment).permit(:request_code, :attachment_name, :attachment_path, :status)
    end
end
