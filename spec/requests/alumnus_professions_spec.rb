require 'rails_helper'

RSpec.describe "AlumnusProfessions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com") }
  let(:profession) { Profession.create!(title: "Engineer") }
  let!(:alumnus_profession) { AlumnusProfession.create!(alumnus: alumnus, profession: profession, field: "Software") }

  describe "DELETE /destroy" do
    it "removes the profession" do
      expect {
        delete alumnus_profession_path(alumnus_profession)
      }.to change(AlumnusProfession, :count).by(-1)

      expect(response).to redirect_to(edit_alumnus_path(alumnus))
    end
  end
end
