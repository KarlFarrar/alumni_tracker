require 'rails_helper'

RSpec.describe "AlumnusExperiences", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/alumnus_experiences/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/alumnus_experiences/update"
      expect(response).to have_http_status(:success)
    end
  end

end
