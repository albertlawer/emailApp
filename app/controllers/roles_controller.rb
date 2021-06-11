class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @permissions = @role.permissions
  end

  # GET /roles/new
  def new
    @role = Role.new
    @permissions = Permission.where("id != '1'").where("subject_class !='Role'").compact
    @role_permissions = @role.permissions.collect{|p| p.id}
  end

  # GET /roles/1/edit
  def edit
    @permissions = Permission.where("id != '1'").where("subject_class !='Role'").compact
    @role_permissions = @role.permissions.collect{|p| p.id}
  end

  # POST /roles
  # POST /roles.json
  def create
    @permissions = Permission.where("id != '1'").where("subject_class !='Role'").compact
    @role = Role.new(role_params)
    @role.permissions = []
    @role.set_permissions(params[:permissions]) if params[:permissions]

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    @permissions = Permission.where("id != '1'").where("subject_class !='Role'").compact
    @role.permissions = []
    @role.set_permissions(params[:permissions]) if params[:permissions]
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :permissions => [])
    end
    
    def is_super_admin?
      redirect_to root_path and return unless current_user.super_admin?
    end
end
