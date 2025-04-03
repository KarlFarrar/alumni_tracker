# app/controllers/directory/students_controller.rb
class Directory::StudentsController < ApplicationController
    # This controller doesn't require admin access
  
    def index
      # Start with a base query that includes necessary associations
      @students = Student.includes(:student_experiences, :experiences)
        .joins("LEFT JOIN users ON students.uin = users.uin")
        .order(classification: :desc)
  
      # Search by name if search parameter is present
      if params[:search].present?
        search_term = "%#{params[:search].downcase}%"
        @students = @students.where(
          "LOWER(users.first_name) LIKE ? OR LOWER(users.last_name) LIKE ?", 
          search_term, search_term
        )
      end
  
      # Filter by major if selected
      if params[:major].present?
        @students = @students.where(major: params[:major])
      end
  
      # Filter by classification if selected
      if params[:classification].present?
        @students = @students.where(classification: params[:classification])
      end
  
      # Filter by experience if selected
      if params[:experience_id].present?
        experience_id = params[:experience_id]
        @students = @students.joins(:student_experiences)
                             .where(student_experiences: { experience_id: experience_id })
                             .distinct
      end
    end
  
    def show
      @student = Student.find(params[:id])
    end
  end