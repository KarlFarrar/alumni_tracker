class AlumniController < ApplicationController
  before_action :set_alumnus, only: [:show, :claim_experiences]

  # GET /alumni or /alumni.json
  def index
    @alumni = Alumnus.all
  end

  # GET /alumni/1 or /alumni/1.json
  def show
    @experiences = Experience.all   # Only show unclaimed experiences
  end

  def claim_experiences
    selected_experience_ids = params[:experience_ids]&.map(&:to_i) || []
  
    # Find all experiences the alumnus currently has
    current_experience_ids = @alumnus.experience_ids
  
    # Find experiences to add (newly selected but not already claimed)
    new_experience_ids = selected_experience_ids - current_experience_ids
    new_experiences = Experience.where(id: new_experience_ids)
  
    # Find experiences to remove (previously claimed but now unselected)
    removed_experience_ids = current_experience_ids - selected_experience_ids
    removed_experiences = Experience.where(id: removed_experience_ids)
  
    # Add new experiences
    @alumnus.experiences << new_experiences
  
    # Remove deselected experiences
    @alumnus.experiences.destroy(removed_experiences)
  
    respond_to do |format|
      format.html { redirect_to @alumnus, notice: "Experiences updated!" }
      format.turbo_stream
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
    def alumni_params
      params.require(:alumnus).permit(
        :uin, :email, :cohort_year, :team_affiliation, :profession_title,
        :availability, :phone_number, :biography,
        experience_ids: [] # Allow selecting multiple experiences
      )
    end
end
