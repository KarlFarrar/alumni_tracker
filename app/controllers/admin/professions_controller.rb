# app/controllers/admin/professions_controller.rb
class Admin::ProfessionsController < ApplicationController
    layout 'admin'
    
    def index
      @professions = Profession.all.order(created_at: :desc)
    end
    
    def create
      @profession = Profession.new(profession_params)
      
      if @profession.save
        redirect_to admin_professions_path, notice: 'Profession was successfully created.'
      else
        redirect_to admin_professions_path, alert: 'Failed to create profession.'
      end
    end
    
    def destroy
      @profession = Profession.find(params[:id])
      @profession.destroy
      redirect_to admin_professions_path, notice: 'Profession was successfully deleted.'
    end
    
    private
    
    def profession_params
      params.require(:profession).permit(:title)
    end
  end