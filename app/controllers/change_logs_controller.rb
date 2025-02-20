class ChangeLogsController < ApplicationController
  # before_action :authenticate_user!  # Ensure only logged-in users can access logs

  def index
    @logs = ChangeLog.order(created_at: :desc).page(params[:page]).per(20)  # Paginate results (optional)
    render :index
  end
end
