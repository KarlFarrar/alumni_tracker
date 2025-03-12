require 'rails_helper'

RSpec.describe "Professions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  describe "POST /create" do
    context "without alumnus association" do
      it "creates a new profession and redirects to index" do
        post professions_path, params: { 
          profession: { 
            field: "Software Engineer" 
          } 
        }
        expect(response).to redirect_to(professions_path)
      end
    end

    context "with alumnus association" do
      let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com") }

      it "creates a new profession and redirects to alumnus" do
        post professions_path, params: { 
          profession: { 
            field: "Doctor",
            alumnus_id: alumnus.id 
          } 
        }
        expect(response).to redirect_to(alumnus_path(alumnus))
      end
    end
  end
end
