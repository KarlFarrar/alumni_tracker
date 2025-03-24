class AlumnusProfessionsController < ApplicationController
    before_action :set_alumnus_profession, only: [:edit, :update]
  
    # GET /alumnus_professions/:id/edit
    def edit
      @alumnus_profession = AlumnusProfession.find(params[:id])
    end
  
    # PATCH/PUT /alumnus_professions/:id
    def update
      if @alumnus_profession.update(alumnus_profession_params)
        redirect_to edit_alumnus_path(@alumnus_profession.alumnus), notice: "Profession details updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /alumnus_professions/:id
    def destroy
      @alumnus_profession = AlumnusProfession.find_by(id: params[:id])

      if @alumnus_profession
        @alumnus_profession.destroy
        redirect_to alumnus_path(@alumnus_profession.alumnus), notice: "Profession removed!"
      else
        redirect_to alumnus_path(@alumnus_profession.alumnus), alert: "Failed to remove profession!"
      end
    end
  
    private
  
    def set_alumnus_profession
      @alumnus_profession = AlumnusProfession.find(params[:id])
    end
  
    def alumnus_profession_params
      params.require(:alumnus_profession).permit(:field)
    end
  end
  