require 'rails_helper'

RSpec.describe "AlumnusProfessions", type: :request do
  before do
    # Skip authentication in tests if needed
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: "123456789") }
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com", user: user) }
  let(:profession) { Profession.create!(title: "Engineer") }
  let!(:alumnus_profession) { AlumnusProfession.create!(alumnus: alumnus, profession: profession, field: "Software") }

  describe "DELETE /destroy" do
    it "removes the profession" do
      expect {
        delete alumnus_profession_path(alumnus_profession)
      }.to change(AlumnusProfession, :count).by(-1)

      expect(response).to redirect_to(alumnus_path(alumnus))
    end
  end
end
