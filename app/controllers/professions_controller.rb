class ProfessionsController < ApplicationController
  before_action :set_profession, only: %i[show edit update destroy]

  # GET /professions
  def index
    @professions = Profession.all.order(created_at: :desc)
  end

  # GET /professions/:id
  def show; end

  # GET /professions/new
  def new
    @profession = Profession.new
  end

  # POST /professions
  def create
    Rails.logger.debug "PARAMS RECEIVED: #{params.inspect}"
    @profession = Profession.new(profession_params)

    alumnus = Alumnus.find_by(id: params[:profession][:alumnus_id]) if params[:profession][:alumnus_id].present?

    if @profession.save
      # Link the new profession to the user if alumnus_id is provided
      if alumnus
        AlumnusProfession.create!(
          alumnus: alumnus,
          profession: @profession,
          field: params[:profession][:field] || "Not Set"
        )
        redirect_to edit_alumnus_path(alumnus), notice: "Profession added!"
        return 
      else
        redirect_to professions_path, notice: "Profession created successfully!"
        return
      end

      respond_to do |format|
        if alumnus
          format.html { redirect_to edit_alumnus_path(alumnus), notice: "Profession added!" }
        else
          format.html { redirect_to professions_path, notice: "Profession added!" }
        end
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.js { render json: { errors: @profession.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # GET /professions/:id/edit
  def edit; end

  # PATCH/PUT /professions/:id
  def update
    if @profession.update(profession_params)
      redirect_to @profession, notice: "Profession updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /professions/:id
  def destroy
    @profession.destroy
    redirect_to professions_url, notice: "Profession deleted successfully."
  end

  private

  def set_profession
    @profession = Profession.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to professions_path, alert: "Profession not found."
  end

  def profession_params
    params.require(:profession).permit(:title)
  end
end
