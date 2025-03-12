require 'rails_helper'

RSpec.describe AlumnusProfession, type: :model do
  let(:alumnus) { Alumnus.create!(uin: "123456789", email: "test@example.com") }
  let(:profession) { Profession.create!(title: "Software Engineer") }

  it "is valid with valid attributes" do
    alumnus_profession = AlumnusProfession.new(
      alumnus: alumnus,
      profession: profession,
      field: "Technology"
    )
    expect(alumnus_profession).to be_valid
  end

  it "is invalid without a field" do
    alumnus_profession = AlumnusProfession.new(
      alumnus: alumnus,
      profession: profession,
      field: nil
    )
    expect(alumnus_profession).to be_invalid
  end

  describe "associations" do
    it { should belong_to(:alumnus) }
    it { should belong_to(:profession) }
  end
end
