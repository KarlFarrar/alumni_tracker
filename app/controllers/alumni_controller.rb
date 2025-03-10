class AlumniController < ApplicationController
  before_action :set_alumnus, only: [:show, :claim_experiences]
  skip_before_action :authenticate_gmail!, only: [:new]

  # GET /alumni or /alumni.json
  def index
    @alumni = Alumnus.all
  end

  # GET /alumni/1 or /alumni/1.json
  def show
    @experiences = Experience.all   # Only show unclaimed experiences
  end

  def claim_experiences
    alumnus = Alumnus.find(params[:id])
    experience = Experience.find_by(id: params[:experience_id])

    if experience
      alumnus_experience = AlumnusExperience.create(
        alumnus: alumnus,
        experience: experience,
        date_received: params[:date_received],
        custom_description: params[:custom_description]
      )

      respond_to do |format|
        if alumnus_experience.persisted?
          format.html { redirect_to alumnus_path(alumnus), notice: "Experience added successfully!" }
          format.turbo_stream { render turbo_stream: turbo_stream.append("claimed_experiences", partial: "alumnus_experiences/experience", locals: { alumnus_experience: alumnus_experience }) }
        else
          format.html { redirect_to alumnus_path(alumnus), alert: "Failed to add experience." }
        end
      end
    end
    selected_experience_ids = params[:experience_ids].reject(&:blank?) # Remove blank selections
    selected_experiences = Experience.where(id: selected_experience_ids)

    @alumnus.experiences << selected_experiences.reject { |exp| @alumnus.experiences.include?(exp) }

    redirect_to @alumnus, notice: "Experiences successfully claimed!"
  end
  

  def claim_experiences
    alumnus = Alumnus.find(params[:id])
    experience = Experience.find_by(id: params[:experience_id])

    if experience
      alumnus_experience = AlumnusExperience.create(
        alumnus: alumnus,
        experience: experience,
        date_received: params[:date_received],
        custom_description: params[:custom_description]
      )

      respond_to do |format|
        if alumnus_experience.persisted?
          format.html { redirect_to alumnus_path(alumnus), notice: "Experience added successfully!" }
          format.turbo_stream { render turbo_stream: turbo_stream.append("claimed_experiences", partial: "alumnus_experiences/experience", locals: { alumnus_experience: alumnus_experience }) }
        else
          format.html { redirect_to alumnus_path(alumnus), alert: "Failed to add experience." }
        end
      end
    end
  end
  

  # GET /alumni/new
  def new
    @alumnus = Alumnus.new
  end

  # GET /alumni/1/edit
  def edit
  end

  # POST /alumni or /alumni.json
  def create
    @alumnus = Alumnus.new(alumnus_params)

    respond_to do |format|
      if @alumnus.save
        format.html { redirect_to @alumnus, notice: "Alumnus was successfully created." }
        format.json { render :show, status: :created, location: @alumnus }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alumnus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumni/1 or /alumni/1.json
  def update
    respond_to do |format|
      if @alumnus.update(alumnus_params)
        format.html { redirect_to @alumnus, notice: "Alumnus was successfully updated." }
        format.json { render :show, status: :ok, location: @alumnus }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alumnus.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_experience
    alumnus = Alumnus.find(params[:id])
    alumnus_experience = AlumnusExperience.find_by(alumnus_id: alumnus.id, experience_id: params[:experience_id])

    if alumnus_experience
      alumnus_experience.destroy

      respond_to do |format|
        format.html { redirect_to alumnus_path(alumnus), notice: "Experience removed successfully!" }
        format.turbo_stream { render turbo_stream: turbo_stream.remove("experience_#{params[:experience_id]}") }
      end
    else
      respond_to do |format|
        format.html { redirect_to alumnus_path(alumnus), alert: "Failed to remove experience." }
      end
    end
  end

  # DELETE /alumni/1 or /alumni/1.json
  def destroy
    @alumnus.destroy!

    respond_to do |format|
      format.html { redirect_to alumni_path, status: :see_other, notice: "Alumnus was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumnus
      @alumnus = Alumnus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alumnus_params
      params.require(:alumnus).permit(
        :uin, :email, :cohort_year, :team_affiliation, :profession_title,
        :availability, :phone_number, :biography,
        experience_ids: [] # Allow selecting multiple experiences
      )
    end
end
