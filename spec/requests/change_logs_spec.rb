require 'rails_helper'

RSpec.describe "ChangeLogs", type: :request do
  before do
    # Mock authentication by bypassing the authenticate_user! method
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end
  describe "GET /index" do
    it "returns http success" do
      get change_logs_path
      expect(response).to have_http_status(:success)
    end
  end
end
