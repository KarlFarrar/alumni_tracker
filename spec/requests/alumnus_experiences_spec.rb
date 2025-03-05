require 'rails_helper'

require 'rails_helper'

RSpec.describe "AlumnusExperiences", type: :request do
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com") }
  let(:experience) { Experience.create!(title: "Best Developer", experience_type: "Award") }
  let(:alumnus_experience) { AlumnusExperience.create!(alumnus: alumnus, experience: experience, date_received: "2021-01-01", custom_description: "Won award") }

  describe "GET /edit" do
    it "returns http success" do
      get edit_alumnus_experience_path(alumnus_experience)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "updates the experience and redirects" do
      patch alumnus_experience_path(alumnus_experience), params: { alumnus_experience: { custom_description: "Updated description" } }
      expect(response).to redirect_to(alumnus_path(alumnus))
      alumnus_experience.reload
      expect(alumnus_experience.custom_description).to eq("Updated description")
    end
  end
end
