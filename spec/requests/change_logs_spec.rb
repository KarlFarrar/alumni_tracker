require 'rails_helper'

RSpec.describe "ChangeLogs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get change_logs_path
      expect(response).to have_http_status(:success)
    end
  end

end
