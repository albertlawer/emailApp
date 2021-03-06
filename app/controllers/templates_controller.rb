class TemplatesController < ApplicationController
  before_action :set_template, only: [:edit, :update, :destroy]
  before_action :check_level, only: [:new]
  skip_before_filter :authenticate_user!, :only => [:getbody]
  skip_before_action :verify_authenticity_token, :only => [:getbody]

  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.where(company_id: current_user.client_id)
  end

  # GET /templates/1
  # GET /templates/1.json
  def getbody
    _body = Template.where(id: params[:the_id]).pluck(:body)[0]

    payload = {
      resp_body: _body,
      status: 200
    }
    render :json => payload, :status => 200




  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to templates_url, notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to templates_url, notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
      if @template.company_id != current_user.client_id
        respond_to do |format|
          format.html { redirect_to templates_path, alert: 'Sorry! You do not have permissions to view this.' }
        end
      end
    end

    def check_level
      the_num = Template.where(company_id: current_user.client_id).count()
      payment_id = ClientInfo.where(id: current_user.client_id).pluck(:payment_type)[0]
      the_set_count = PaymentType.where(id: payment_id).pluck(:email_templates)[0]
      if the_set_count <= the_num
        respond_to do |format|
          format.html { redirect_to templates_path, alert: 'Sorry! You have exhausted your allowance, please upgrade your package.' }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:name, :body, :status, :company_id, :user_id)
    end
end
