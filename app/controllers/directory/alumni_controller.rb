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

    if params[:experience_id].present?
      experience_id = params[:experience_id]
      @alumni = @alumni.joins(:alumnus_experiences)
                       .where(alumnus_experiences: { experience_id: experience_id })
                       .distinct
    end
    # Filter by profession if selected
    if params[:profession_id].present?
      profession_id = params[:profession_id]
      @alumni = @alumni.joins(:alumnus_professions)
                       .where(alumnus_professions: { profession_id: profession_id })
                       .distinct
    end

    # Start with a base query that includes necessary associations
    @alumni = Alumnus.includes(:alumnus_professions, :professions)
    .joins("LEFT JOIN users ON alumni.uin = users.uin")
    .order(cohort_year: :desc)

    # Search by name if search parameter is present
    if params[:search].present?
    search_term = "%#{params[:search].downcase}%"
    @alumni = @alumni.where(
    "LOWER(users.first_name) LIKE ? OR LOWER(users.last_name) LIKE ?", 
    search_term, search_term
    )
    end

    # Existing filters remain unchanged
    if params[:available] == "1"
    @alumni = @alumni.where(availability: true)
    end

    if params[:cohort_year].present?
    @alumni = @alumni.where(cohort_year: params[:cohort_year])
    end

    if params[:profession_id].present?
    profession_id = params[:profession_id]
    @alumni = @alumni.joins(:alumnus_professions)
        .where(alumnus_professions: { profession_id: profession_id })
        .distinct
    end

    if params[:experience_id].present?
    experience_id = params[:experience_id]
    @alumni = @alumni.joins(:alumnus_experiences)
        .where(alumnus_experiences: { experience_id: experience_id })
        .distinct
    end
  end

  def show
    @alumnus = Alumnus.find(params[:id])
  end
end