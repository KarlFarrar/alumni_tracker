require 'rails_helper'

RSpec.describe "/experiences", type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  let(:experience) { Experience.create!(title: "Title1", experience_type: "Certification") } 

  describe "GET /new" do
    it "renders a successful response" do
      get new_experience_path
      expect(response).to have_http_status(:success)
    end
  end
end
