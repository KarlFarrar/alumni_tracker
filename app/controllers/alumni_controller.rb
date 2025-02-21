class AlumniController < ApplicationController
  before_action :set_alumnus, only: %i[ show edit update destroy ]

  # GET /alumni or /alumni.json
  def index
    @alumni = Alumnus.all
  end

  # GET /alumni/1 or /alumni/1.json
  def show
    @experiences = Experience.where(recepient_uin: nil)  # Only show unclaimed experiences
  end

  def claim_experience
    experience = Experience.find(params[:experience_id])
    
    if experience.update(recepient_uin: @alumnus.uin)
      redirect_to @alumnus, notice: "Experience successfully claimed!"
    else
      redirect_to @alumnus, alert: "Failed to claim experience."
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
      @alumnus = Alumnus.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def alumni_params
      params.require(:alumnus).permit(
        :uin, :email,
        experiences_attributes: [:id, :title, :experience_type, :date_interval, :description, :_destroy]
      )
    end
end
