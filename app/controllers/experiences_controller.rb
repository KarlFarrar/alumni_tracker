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
    @experience = Experience.new(experience_params)

    if @experience.save
      redirect_to @experience, notice: "Experience was successfully created."
    else
      render :new, status: :unprocessable_entity
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
    params.require(:experience).permit(:title, :experience_type, :date_interval, :description, :recepient_uin)
  end
end
