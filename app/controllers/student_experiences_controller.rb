class StudentExperiencesController < ApplicationController
    before_action :set_student_experience, only: [:edit, :update, :destroy]
  
  
    def edit
    end
  
    def update
      if @student_experience.update(student_experience_params)
        redirect_to edit_student_path(@student_experience.student), notice: 'Student experience was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
        @experience = Experience.find(params[:id])
        
        # Remove the association in the join table
        StudentExperience.where(experience_id: @experience.id).destroy_all
        
        # Delete the experience itself
        if @experience.destroy
          render json: { success: true }, status: :ok
        else
          render json: { success: false, errors: @experience.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
    private
  
    def set_student_experience
      @student_experience = StudentExperience.find(params[:id])
    end
  
    def student_experience_params
      params.require(:student_experience).permit(:date_received, :custom_description, :placement)
    end
  end
  