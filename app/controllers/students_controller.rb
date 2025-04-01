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
  end

  # GET /students/new
  def new
    @student = Student.new
    @student.build_user
    @student.user.build_gmail
  end

  # GET /students/1/edit
  def edit
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
          user_attributes: [:id, :first_name, :last_name, :middle_initial, :status] # Exclude :uin
        )
      else
        Rails.logger.info "NEW"
        params.require(:student).permit(
          :classification, :major, :resumelink, :email, :phone, :biography,
          user_attributes: [:first_name, :last_name, :middle_initial, :uin, :status] # Allow :uin during creation
        )
      end
    end
end
