require 'rails_helper'

RSpec.describe "ChangeLogs", type: :request do

  before do
    # This will skip the `authenticate_gmails!` before action
    allow(ApplicationController).to receive(:authenticate_gmails!).and_return(true)
  end

  describe "GET /index" do
    it "returns http success" do
      get change_logs_path
      expect(response).to have_http_status(:success)
    end
  end
end
