# frozen_string_literal: true

class Gmails::SessionsController < Devise::SessionsController
  layout 'gmails'
  def after_sign_out_path_for(_resource_or_scope)
    new_gmail_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end
end
