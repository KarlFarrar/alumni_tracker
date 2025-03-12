require 'rails_helper'

RSpec.describe "Professions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  let(:profession) { Profession.create!(title: "Doctor") }

  describe "GET /index" do
    it "renders a successful response" do
      get professions_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get profession_path(profession)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_profession_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new profession" do
      expect {
        post professions_path, params: { profession: { title: "Lawyer" } }
      }.to change(Profession, :count).by(1)
      expect(response).to redirect_to(profession_path(Profession.last))
    end
  end

  describe "PATCH /update" do
    it "updates the profession" do
      patch profession_path(profession), params: { profession: { title: "Surgeon" } }
      profession.reload
      expect(profession.title).to eq("Surgeon")
    end
  end

  describe "DELETE /destroy" do
    it "deletes the profession" do
      profession
      expect {
        delete profession_path(profession)
      }.to change(Profession, :count).by(-1)
      expect(response).to redirect_to(professions_path)
    end
  end
end
