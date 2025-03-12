require 'rails_helper'

RSpec.describe "Professions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com") }

  describe "POST /create" do
    it "creates a new profession and redirects" do
      post professions_path, params: { profession: { title: "Doctor" } }
      expect(response).to redirect_to(profession_path(Profession.last))
      follow_redirect!
      expect(response.body).to include("Doctor")
    end
  end
end
