# frozen_string_literal: true

class Gmails::RegistrationsController < Devise::RegistrationsController
   # Override the `new` action to display the registration form
  layout 'gmails'
  def new
    @gmail = Gmail.new
    Rails.logger.info "I got into the new action"
  end

  def choose_role
  end

  # Override the `create` action to handle new account creation
  def create
    # Set the Gmail params from the form submission (email and full_name)
    @gmail = Gmail.new(gmail_params)
    Rails.logger.info "I got into the create action"
    if session[:uid].present? && session[:avatar_url].present?
      Rails.logger.info "Using session data for UID and Avatar URL"
      Rails.logger.info "UID: #{session[:uid]}"
      Rails.logger.info "Avatar URL: #{session[:avatar_url]}"

      @gmail.uid = session[:uid]
      @gmail.avatar_url = session[:avatar_url] 
  else
    Rails.logger.info "Session data is missing!"
  end

    if @gmail.save
      flash[:notice] = "Account created successfully"
      sign_in_and_redirect @gmail, event: :authentication
    else
      flash[:alert] = "There was an error creating your account"
      render :new
    end
  end

  private

  # Strong parameters for creating a Gmail account
  def gmail_params
    params.require(:gmail).permit(:email, :full_name)
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

end
