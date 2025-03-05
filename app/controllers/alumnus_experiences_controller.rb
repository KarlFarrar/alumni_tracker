class AlumnusExperiencesController < ApplicationController
  before_action :set_alumnus_experience, only: [:edit, :update]

  def edit
  end

  def update
    if @alumnus_experience.update(alumnus_experience_params)
      redirect_to alumnus_path(@alumnus_experience.alumnus), notice: "Experience details updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @experience = Experience.find(params[:id])
    
    # Remove the association in the join table
    AlumnusExperience.where(experience_id: @experience.id).destroy_all
    
    # Delete the experience itself
    if @experience.destroy
      render json: { success: true }, status: :ok
    else
      render json: { success: false, errors: @experience.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private

  def set_alumnus_experience
    @alumnus_experience = AlumnusExperience.find(params[:id])
  end

  def alumnus_experience_params
    params.require(:alumnus_experience).permit(:date_received, :custom_description)
  end
end
