class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_gmail!, only: [:new, :create, :show]


  # GET /students or /students.json
  def index
    @students = Student.all
    @current = Student.find_by(uin: current_gmail&.user&.uin_data)
  end

  # GET /students/1 or /students/1.json
  def show
    @current = Student.find_by(uin: current_gmail&.user&.uin_data)
    @experiences = Experience.all
  end

  # GET /students/new
  def new
    @student = Student.new
    @student.build_user
    @student.user.build_gmail
  end

  def claim_experiences
    @student = Student.find(params[:id])
    experience = Experience.find_by(id: params[:experience_id])
    


    if experience
      student_experience = StudentExperience.create(
        student: @student,
        experience: experience,
        date_received: params[:date_received],
        custom_description: params[:custom_description],
        placement: (experience.experience_type.downcase == "competition" ? params[:placement] : nil)
      )

      respond_to do |format|
        if student_experience.persisted?
          format.html { redirect_to edit_student_path(@student, anchor: "experience"), notice: "Experience claimed successfully!" }
          format.turbo_stream { render turbo_stream: turbo_stream.append("claimed_experiences", partial: "student_experiences/experience", locals: { student_experience: student_experience }) }
        else
          format.html { redirect_to student_path(student), alert: "Failed to add experience." }
        end
      end
    end
  end

  def remove_experience
    student = Student.find(params[:id])
    student_experience = StudentExperience.find_by(student_id: student.id, experience_id: params[:experience_id])

    if student_experience
      student_experience.destroy

      respond_to do |format|
        format.html { redirect_to student_path(student), notice: "Experience removed successfully!" }
        format.turbo_stream { render turbo_stream: turbo_stream.remove("experience_#{params[:experience_id]}") }
      end
    else
      respond_to do |format|
        format.html { redirect_to student_path(student), alert: "Failed to remove experience." }
      end
    end
  end


  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id]) if params[:id].present?
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    @student.user.status = "student"

    if @student.save
      # Now, associate Gmail after user is definitely saved
      @student.user.create_gmail(email: session[:email], uid: session[:uid], avatar_url: session[:avatar_url])
      sign_in(@student.user.gmail)

      respond_to do |format|
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @alumnus }
      end
    else
      Rails.logger.info "Errors: #{@student.errors.full_messages}"
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    #Make it so that user and gmail is also deleted
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_path, status: :see_other, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def student_params
      if params[:id].present?
        Rails.logger.info "UPDATE"
        params.require(:student).permit(
          :classification, :major, :resumelink, :email, :phone, :biography,
          experience_ids: [], 
          user_attributes: [:id, :first_name, :last_name, :middle_initial, :status] # Exclude :uin
        )
      else
        Rails.logger.info "NEW"
        params.require(:student).permit(
          :classification, :major, :resumelink, :email, :phone, :biography,
          experience_ids: [], 
          user_attributes: [:first_name, :last_name, :middle_initial, :uin, :status] # Allow :uin during creation
        )
      end
    end
end
