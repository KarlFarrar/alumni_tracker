require 'rails_helper'

RSpec.describe "/experiences", type: :request do
  let(:experience) { Experience.create!(title: "Title1", experience_type: "Certification") } # ✅ Removed `date_interval`

  describe "GET /new" do
    it "renders a successful response" do
      get new_experience_path
      expect(response).to have_http_status(:success)
    end
  end
end
