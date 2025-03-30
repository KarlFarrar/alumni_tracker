class Directory::AlumniController < ApplicationController
  # This controller doesn't require admin access

  def index
    @alumni = Alumnus.all.order(cohort_year: :desc)
    
    # Filter by availability if checkbox is checked
    if params[:available] == "1"
      @alumni = @alumni.where(availability: true)
    end
    
    # Filter by cohort year if selected
    if params[:cohort_year].present?
      @alumni = @alumni.where(cohort_year: params[:cohort_year])
    end
    
    # Filter by profession if selected
    if params[:profession_id].present?
      profession_id = params[:profession_id]
      @alumni = @alumni.joins(:alumnus_professions)
                       .where(alumnus_professions: { profession_id: profession_id })
                       .distinct
    end
  end

  def show
    @alumnus = Alumnus.find(params[:id])
  end
end