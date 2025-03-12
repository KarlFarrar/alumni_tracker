require 'rails_helper'

RSpec.describe "AlumnusProfessions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com") }
  let(:profession) { Profession.create!(title: "Software Engineer") }
  let!(:alumnus_profession) { AlumnusProfession.create!(alumnus: alumnus, profession: profession, field: "Tech") }

  describe "DELETE /destroy" do
    it "removes the profession" do
      delete alumnus_profession_path(alumnus_profession)
      expect(response).to redirect_to(alumnus_path(alumnus))
      expect(AlumnusProfession.find_by(id: alumnus_profession.id)).to be_nil
    end
  end
end
