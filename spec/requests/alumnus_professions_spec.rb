require 'rails_helper'

RSpec.describe "AlumnusProfessions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com") }
  let(:profession) { Profession.create!(title: "Engineer") }
  let(:alumnus_profession) {
    AlumnusProfession.create!(alumnus: alumnus, profession: profession, field: "Mechanical")
  }

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_alumnus_profession_path(alumnus_profession)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "updates the profession and redirects" do
      patch alumnus_profession_path(alumnus_profession), params: {
        alumnus_profession: { field: "Electrical" }
      }
      alumnus_profession.reload
      expect(alumnus_profession.field).to eq("Electrical")
      expect(response).to redirect_to(alumnus_path(alumnus))
    end
  end

  describe "DELETE /destroy" do
    it "removes the profession" do
      alumnus_profession
      expect {
        delete alumnus_profession_path(alumnus_profession)
      }.to change(AlumnusProfession, :count).by(-1)
      expect(response).to redirect_to(alumnus_path(alumnus))
    end
  end

  describe "POST /claim_professions" do
    it "claims a new profession for an alumnus" do
      expect {
        post claim_professions_alumnus_path(alumnus), params: {
          profession_id: profession.id,
          field: "Mechanical"
        }
      }.to change(AlumnusProfession, :count).by(1)
      expect(response).to redirect_to(alumnus_path(alumnus))
    end
  end
end
