class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_gmail!
  before_action :set_welcome_back_message, if: :gmail_signed_in?

  protected

  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome back, #{resource.first_name}!" unless session[:welcome_message_shown]
    session[:welcome_message_shown] = true
    root_path # Change this to wherever you want to redirect the user after login
  end

  private

  def set_welcome_back_message
    session[:welcome_message_shown] ||= false
  end
end
