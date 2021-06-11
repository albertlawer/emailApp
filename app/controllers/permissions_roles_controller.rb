class PermissionsRolesController < ApplicationController
  before_action :set_permissions_role, only: [:show, :edit, :update, :destroy]

  # GET /permissions_roles
  # GET /permissions_roles.json
  def index
    @permissions_roles = PermissionsRole.all
  end

  # GET /permissions_roles/1
  # GET /permissions_roles/1.json
  def show
  end

  # GET /permissions_roles/new
  def new
    @permissions_role = PermissionsRole.new
  end

  # GET /permissions_roles/1/edit
  def edit
  end

  # POST /permissions_roles
  # POST /permissions_roles.json
  def create
    @permissions_role = PermissionsRole.new(permissions_role_params)

    respond_to do |format|
      if @permissions_role.save
        format.html { redirect_to @permissions_role, notice: 'Permissions role was successfully created.' }
        format.json { render :show, status: :created, location: @permissions_role }
      else
        format.html { render :new }
        format.json { render json: @permissions_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissions_roles/1
  # PATCH/PUT /permissions_roles/1.json
  def update
    respond_to do |format|
      if @permissions_role.update(permissions_role_params)
        format.html { redirect_to @permissions_role, notice: 'Permissions role was successfully updated.' }
        format.json { render :show, status: :ok, location: @permissions_role }
      else
        format.html { render :edit }
        format.json { render json: @permissions_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions_roles/1
  # DELETE /permissions_roles/1.json
  def destroy
    @permissions_role.destroy
    respond_to do |format|
      format.html { redirect_to permissions_roles_url, notice: 'Permissions role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permissions_role
      @permissions_role = PermissionsRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permissions_role_params
      params.require(:permissions_role).permit(:permission_id, :role_id)
    end
end
