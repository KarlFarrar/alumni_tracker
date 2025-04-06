require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
    allow_any_instance_of(Admin::DashboardController).to receive(:require_admin).and_return(true)
  end
  describe "GET /index" do
    it "returns http success" do
      get "/admin/dashboard/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/dashboard/show"
      expect(response).to have_http_status(:success)
    end
  end

end
