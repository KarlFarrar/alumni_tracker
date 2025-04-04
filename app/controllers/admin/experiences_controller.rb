# app/controllers/admin/experiences_controller.rb
class Admin::ExperiencesController < ApplicationController
    layout 'admin'
    #before_action :authenticate_admin!
    
    def index
      @experiences = Experience.all.order(created_at: :desc)
    end
    
    def create
      @experience = Experience.new(experience_params)
      
      if @experience.save
        redirect_to admin_experiences_path, notice: 'Experience was successfully created.'
      else
        redirect_to admin_experiences_path, alert: 'Failed to create experience.'
      end
    end
    
    def show
      @experience = Experience.find(params[:id])
    end
    
    def edit
      @experience = Experience.find(params[:id])
    end
    
    def update
      @experience = Experience.find(params[:id])
      if @experience.update(experience_params)
        redirect_to admin_experiences_path, notice: 'Experience was successfully updated.'
      else
        render :edit
      end
    end
    
    def destroy
      @experience = Experience.find(params[:id])
      @experience.destroy
      redirect_to admin_experiences_path, notice: 'Experience was successfully deleted.'
    end
    
    private
    
    def experience_params
      params.require(:experience).permit(:title, :experience_type)
    end
    
    # def authenticate_admin!
    #   # Check if user is logged in and is an admin
    #   unless current_gmail&.user.isAdmin
    #     flash[:alert] S= "You must be an admin to access this page."
    #     redirect_to root_path
    #   end
    # end
  end