class Admin::UsersController < ApplicationController
    layout 'admin'
    
    def index
      @users = User.all.order(created_at: :desc)
    end
    
    def show
      @user = User.find(params[:id])
    end
    
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end
    
    def edit
      @user = User.find(params[:id])
    end
    
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
    
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted.'
    end

    def give_admin
      @user = User.find(params[:id])
      if @user.update(isAdmin: true)
        redirect_to admin_users_path, notice: "#{@user.first_name} was given admin privileges."
      else
        redirect_to admin_users_path, alert: "Failed to update user."
      end
    end
    
    private
    
    def user_params
      params.require(:user).permit(:uin, :first_name, :last_name, :middle_initial, :status, :isAdmin)
    end
  end