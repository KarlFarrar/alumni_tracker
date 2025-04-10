class Admin::AlumniController < ApplicationController
  layout 'admin'
  
  def index
    @alumni = Alumnus.all.order(created_at: :desc)
  end
  
  def show
    @alumnus = Alumnus.find(params[:id])
  end
  
  def new
    @alumnus = Alumnus.new
  end
  
  def create
    # Start a database transaction to ensure both user and alumnus are created or neither is
    ActiveRecord::Base.transaction do
      # Generate a new UIN by finding the max UIN in the User table and iterating downward
      # until we find an available UIN
      max_uin = User.maximum(:uin) || 900000000  # If no UINs exist, start from 900000000
      new_uin = max_uin - 1
      
      # Keep decrementing until we find an available UIN
      while User.exists?(uin: new_uin) && new_uin > 100000000
        new_uin -= 1
      end
      
      # Check if we've reached the lower limit without finding an available UIN
      if new_uin <= 100000000
        raise ActiveRecord::RecordInvalid.new("Could not find an available UIN")
      end
      
      # Create a new user
      @user = User.new(
        uin: new_uin,
        first_name: params[:first_name],
        last_name: params[:last_name],
        middle_initial: params[:middle_initial] || '',
        status: 'alumni',
        isAdmin: false
      )
      
      # Save the user
      @user.save!
      
      # Create the alumnus associated with the user
      @alumnus = Alumnus.new(
        uin: new_uin,
        cohort_year: params[:cohort_year],
        team_affiliation: params[:team_affiliation],
        profession_title: params[:profession_title],
        availability: params[:availability],
        email: params[:email],
        phone_number: params[:phone_number],
        LinkedIn: params[:LinkedIn]
      )
      
      # Save the alumnus
      @alumnus.save!
      
      # Redirect to the index page with a success message
      redirect_to admin_alumni_path, notice: "Alumnus was successfully created with UIN: #{new_uin}."
    rescue ActiveRecord::RecordInvalid => e
      # Log the error
      Rails.logger.error("Failed to create alumnus: #{e.message}")
      
      # If there's an error, render the new form again
      @alumnus ||= Alumnus.new
      flash.now[:alert] = "Failed to create alumnus: #{e.message}"
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @alumnus = Alumnus.find(params[:id])
    redirect_to edit_alumnus_path(@alumnus)
  end
  
  def update
    @alumnus = Alumnus.find(params[:id])
    if @alumnus.update(alumnus_params)
      redirect_to admin_alumni_path, notice: 'Alumnus was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @alumnus = Alumnus.find(params[:id])
    @alumnus.destroy
    redirect_to admin_alumni_path, notice: 'Alumnus was successfully deleted.'
  end
  
  private
  
  def alumnus_params
    params.require(:alumnus).permit(:uin, :cohort_year, :team_affiliation, 
                                     :profession_title, :availability, :email, 
                                     :phone_number, :LinkedIn)
  end
end