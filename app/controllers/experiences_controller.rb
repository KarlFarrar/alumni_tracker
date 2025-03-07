class ExperiencesController < ApplicationController
  before_action :set_experience, only: %i[show edit update destroy]

  def index
    @experiences = Experience.all.order(created_at: :desc)
  end

  def show; end

  def new
    @experience = Experience.new
  end

  def create
    Rails.logger.debug "PARAMS RECEIVED: #{params.inspect}"
    @experience = Experience.new(experience_params)
    alumnus = Alumnus.find_by(id: params[:experience][:alumnus_id]) if params[:experience][:alumnus_id].present?

    if @experience.save
      alumnus.experiences << @experience if alumnus 
      respond_to do |format|
        if alumnus
          format.html { redirect_to alumnus_path(alumnus), notice: "Experience added!" }
        else
          format.html { redirect_to experiences_path, notice: "Experience added!" }
        end
        forma t.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.js { render json: { errors: @experience.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    if @experience.update(experience_params)
      redirect_to @experience, notice: "Experience was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @experience.destroy
    redirect_to experiences_url, notice: "Experience was successfully deleted."
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:title, :experience_type)
  end
end
