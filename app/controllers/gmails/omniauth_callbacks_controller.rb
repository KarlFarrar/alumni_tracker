# frozen_string_literal: true

class Gmails::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    #gmail = Gmail.from_google(**from_google_params)
    auth = request.env["omniauth.auth"]
    email = auth.info.email
    gmail = Gmail.find_by(email: email)

    if gmail.present? && gmail.persisted?
      sign_out_all_scopes
      sign_in_and_redirect gmail, event: :authentication
    else
      session[:uid] = auth.uid
      session[:avatar_url] = auth.info.image
      session[:email] = auth.info.email
      flash[:alert] = t 'No account found. Please create an account'
      redirect_to choose_role_registration_path
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_gmail_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    flash[:notice] = "Welcome back, #{resource_or_scope.user.first_name}!" unless session[:welcome_message_shown]
    session[:welcome_message_shown] = true
    stored_location_for(resource_or_scope) || root_path
  end

  private

  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  def set_welcome_back_message
    session[:welcome_message_shown] ||= false
  end
end
