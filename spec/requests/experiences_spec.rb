require 'rails_helper'
require 'ostruct'


RSpec.describe "AlumnusExperiences", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_gmail).and_return(OpenStruct.new(avatar_url: "https://lh3.googleusercontent.com/a/ACg8ocLqULf2PS9IRJMnqzCC9JNGIfzMoDvHXgIQrdNViXOccYZEHw=s288-c-no"))
  end

  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: "123456789") }
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com", user: user) }
  let(:experience) { Experience.create!(title: "Best Developer", experience_type: "Award") }
  let(:alumnus_experience) { 
    AlumnusExperience.create!(
      alumnus: alumnus, 
      experience: experience, 
      date_received: "2021-01-01", 
      custom_description: "Won award"
    ) 
  }

  describe "GET /edit" do
    it "returns http success" do
      get edit_alumnus_experience_path(alumnus_experience)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "updates the experience and redirects" do
      patch alumnus_experience_path(alumnus_experience), params: { 
        alumnus_experience: { custom_description: "Updated description" } 
      }
      expect(response).to redirect_to(edit_alumnus_path(alumnus))
      alumnus_experience.reload
      expect(alumnus_experience.custom_description).to eq("Updated description")
    end
  end
end
