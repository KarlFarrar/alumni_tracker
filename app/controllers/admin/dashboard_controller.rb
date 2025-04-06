class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :require_admin
 
  def index
    @alumni = Alumnus.all.order(created_at: :desc)
  end

  def show
    @alumnus = Alumnus.find_by(id: params[:id])
  end

  def require_admin
    unless current_gmail&.user&.admin?
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end
end
