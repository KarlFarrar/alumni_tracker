class Admin::AlumniController < ApplicationController
    layout 'admin'
    
    def index
      @alumni = Alumnus.all.order(created_at: :desc)
    end
    
    def show
      @alumnus = Alumnus.find(params[:id])
    end
    
    def edit
      @alumnus = Alumnus.find(params[:id])
    end
    
    def update
      @alumnus = Alumnus.find(params[:id])
      if @alumnus.update(alumnus_params)
        redirect_to admin_alumni_path, notice: 'Alumnus was successfully updated.'
      else
        render :edit
      end
    end
    
    def destroy
      @alumnus = Alumnus.find(params[:id])
      @alumnus.destroy
      redirect_to admin_alumni_path, notice: 'Alumnus was successfully deleted.'
    end
    
    private
    
    def alumnus_params
      params.require(:alumnus).permit(:uin, :cohort_year, :team_affiliation, 
                                       :profession_title, :availability, :email, 
                                       :phone_number, :biography)
    end
  end