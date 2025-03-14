class Admin::DashboardController < ApplicationController
  layout 'admin'
 
  def index
    @alumni = Alumnus.all.order(created_at: :desc)
  end

  def show
    @alumnus = Alumnus.find_by(id: params[:id])
  end
end
