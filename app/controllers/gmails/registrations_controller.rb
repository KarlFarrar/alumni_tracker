# frozen_string_literal: true

class Gmails::RegistrationsController < Devise::RegistrationsController
   # Override the `new` action to display the registration form
  def new
    @gmail = Gmail.new
  end

  def choose_role
  end

  # Override the `create` action to handle new account creation
  def create
    # Here you can use the params from the form and create a new Gmail record
    @gmail = Gmail.new(gmail_params)
    
    if @gmail.save
      # Redirect user to the homepage or dashboard after successful creation
      flash[:notice] = "Account created successfully"
      sign_in_and_redirect @gmail, event: :authentication
    else
      # Handle any errors and re-render the form
      flash[:alert] = "There was an error creating your account"
      render :new
    end
  end

  private

  # Strong parameters for creating a Gmail account
  def gmail_params
    params.require(:gmail).permit(:email, :full_name, :avatar_url)
  end
end
