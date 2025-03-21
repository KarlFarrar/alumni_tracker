class AlumniController < ApplicationController
  before_action :set_alumnus, only: [:show, :edit, :update, :destroy, :claim_experiences, :claim_professions, :remove_experience, :remove_profession]
  skip_before_action :authenticate_gmail!, only: [:new]

  # GET /alumni or /alumni.json
  def index
    @alumni = Alumnus.all
  end

  # GET /alumni/1 or /alumni/1.json
  def show
    @experiences = Experience.all   # Only show unclaimed experiences
    @professions = Profession.all
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
          format.html { redirect_to edit_alumnus_path(@alumnus), notice: "Experience claimed successfully!" }
          format.turbo_stream { render turbo_stream: turbo_stream.append("claimed_experiences", partial: "alumnus_experiences/experience", locals: { alumnus_experience: alumnus_experience }) }
        else
          format.html { redirect_to alumnus_path(alumnus), alert: "Failed to add experience." }
        end
      end
    end
  end

  # POST /alumni/:id/claim_professions
  def claim_professions
    @alumnus = Alumnus.find(params[:id])
    profession = Profession.find_by(id: params[:profession_id])

    if profession
      alumnus_profession = AlumnusProfession.create(
        alumnus: @alumnus,
        profession: profession,
        field: params[:field]
      )

      respond_to do |format|
        if alumnus_profession.persisted?
          format.html { redirect_to edit_alumnus_path(@alumnus), notice: "Profession claimed successfully!" }
          format.turbo_stream do
            render turbo_stream: turbo_stream.append(
              "claimed_professions",
              partial: "alumnus_professions/profession",
              locals: { alumnus_profession: alumnus_profession }
            )
          end
        else
          format.html { redirect_to @alumnus, alert: "Failed to add profession." }
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
    @alumnus = Alumnus.find(params[:id])
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

  # DELETE /alumni/:id/remove_profession
  def remove_profession
    alumnus_profession = @alumnus.alumnus_professions.find_by(profession_id: params[:profession_id])

    if alumnus_profession
      alumnus_profession.destroy

      respond_to do |format|
        format.html { redirect_to @alumnus, notice: "Profession removed successfully!" }
        format.turbo_stream { render turbo_stream: turbo_stream.remove("profession_#{params[:profession_id]}") }
      end
    else
      respond_to do |format|
        format.html { redirect_to @alumnus, alert: "Failed to remove profession." }
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
        :uin, :email, :cohort_year, :team_affiliation, :availability, :phone_number, :biography,
        experience_ids: [], # Allow selecting multiple experiences
        profession_ids: [], # Allow selecting multiple professions
        professions_attributes: [:title]
      )
    end
end
