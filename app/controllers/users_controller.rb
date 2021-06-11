class UsersController < ApplicationController
  before_action :check_level, only: [:new_user_client,:new_client_user]
  # load_and_authorize_resource
  # before_action :load_permissions
  

  def client_users
    @the_client_id = current_user.client_id
    @users = User.where("role_id IN (3,4) and client_id= #{@the_client_id}").order("username asc")
  end


  def new_user_client
    @user = User.new
    @user.client_id = current_user.client_id
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id]  }
  end
  
  def edit_user_client
    @user = User.find(params[:id])
    @the_client_id = @user.client_id
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id]  }
  end
  
  
  def create_user_client
    @user = User.new(user_params)
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id] }
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to client_users_path, notice: 'Client User was successfully created.' }
        format.json { render :show, status: :created, location: @client_info }
      else
        format.html { render :new_user_client }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def update_user_client
    the_id = params[:user][:id]
    @user = User.find(the_id)
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id]  }
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to client_users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :created, location: @client_info }
      else
        format.html { render :edit_user_client }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end
  




















  def client_user_list
    @the_client_id = params[:client_id]
    @client_name = ClientInfo.where(id: @the_client_id).pluck(:name)[0]    
    @users = User.where("role_id IN (3,4) and client_id= #{@the_client_id}").order("username asc")
  end


  def new_client_user
    @the_client_id = params[:client_id]
    @client_name = ClientInfo.where(id: @the_client_id).pluck(:name)[0]    
    @user = User.new
    @user.client_id = @the_client_id
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id]  }
  end


  def edit_client_user
    @user = User.find(params[:id])
    @the_client_id = @user.client_id
    @client_name = ClientInfo.where(id: @the_client_id).pluck(:name)[0]    
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id]  }
  end
  
  
  def create_client_user
    @user = User.new(user_params)
    @the_client_id = @user.client_id
    @client_name = ClientInfo.where(id: @the_client_id).pluck(:name)[0]    
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id] }
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to client_user_list_path(@the_client_id), notice: 'Client User was successfully created.' }
        format.json { render :show, status: :created, location: @client_info }
      else
        format.html { render :new_client_user }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end



  def update_client_user
    the_id = params[:user][:id]
    @user = User.find(the_id)
    @the_client_id = @user.client_id
    @client_name = ClientInfo.where(id: @the_client_id).pluck(:name)[0] 
    the_users = Role.where("id in (3,4)")
    @roles = the_users.map { |a|[a.name,a.id]  }
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to client_user_list_path(@the_client_id), notice: 'User was successfully updated.' }
        format.json { render :show, status: :created, location: @client_info }
      else
        format.html { render :edit_client_user }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end
















  def admin_users
    if current_user.role_id == 1
      @users = User.where("role_id IN (1,2)").order("username asc")
    elsif current_user.role_id == 2
      @users = User.where("role_id IN (2)").order("username asc")
    end
  end


  def new_admin_user
    @user = User.new
    
    if current_user.role_id == 1
      the_users = Role.where("id in (1,2)")
      @roles = the_users.map { |a|[a.name,a.id]  }
    end  
  end
  

  def admin_users_edit
    @user = User.find(params[:id])
    
    if current_user.role_id == 1
      the_users = Role.where("id in (1,2)")
      @roles = the_users.map { |a|[a.name,a.id]  }
    end  
  end

  
  def admin_create_user
    @user = User.new(user_params)
    
    if current_user.role_id == 1
      the_users = Role.where("id in (1,2)")
      @roles = the_users.map { |a|[a.name,a.id]  }
    end  
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @client_info }
      else
        format.html { render :new_admin_user }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end


  def admin_edit_user
    the_id = params[:user][:id]
    @user = User.find(the_id)
    
    if current_user.role_id == 1
      the_users = Role.where("id in (1,2)")
      @roles = the_users.map { |a|[a.name,a.id]  }
    end  
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :created, location: @client_info }
      else
        format.html { render :admin_users_edit }
        format.json { render json: @client_info.errors, status: :unprocessable_entity }
      end
    end
  end








  
  private
    # Use callbacks to share common setup or constraints between actions.
    def check_level
      if current_user.role_id == 1 || current_user.role_id == 2
        @the_client_id = params[:client_id]
        the_num = User.where(client_id: @the_client_id).count()
        payment_id = ClientInfo.where(id: @the_client_id).pluck(:payment_type)[0]
        the_set_count = PaymentType.where(id: payment_id).pluck(:users)[0]
        if the_set_count <= the_num
          respond_to do |format|
            format.html { redirect_to client_user_list_path, alert: 'Sorry! Client has exhausted his allowance, he should upgrade his package.' }
          end
        end
      else
        @the_client_id = current_user.client_id
        the_num = User.where(client_id: @the_client_id).count()
        payment_id = ClientInfo.where(id: @the_client_id).pluck(:payment_type)[0]
        the_set_count = PaymentType.where(id: payment_id).pluck(:users)[0]
        if the_set_count <= the_num
          respond_to do |format|
            format.html { redirect_to client_users_path, alert: 'Sorry! You have exhausted your allowance, please upgrade your package.' }
          end
        end
      end
    end


    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :username, :role_id, :client_id)
    end
end
