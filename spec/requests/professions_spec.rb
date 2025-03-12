require 'rails_helper'

RSpec.describe "Professions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  describe "POST /create" do
    context "with valid parameters" do
      let!(:alumnus) { Alumnus.create(name: "Test Alumnus") } # Create an alumnus
      it "creates a new profession and redirects to the alumnus path" do
        post professions_path, params: { profession: { field: "Software Engineer", alumnus_id: alumnus.id } } # Include alumnus_id
        expect(response).to redirect_to(alumnus_path(alumnus))
        expect(flash[:notice]).to eq("Profession added!")
      end
    end
  end
end
