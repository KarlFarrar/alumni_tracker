require 'rails_helper'

RSpec.describe "alumni/show", type: :view do
  before(:each) do
    assign(:alumnus, Alumnus.create!(
      uin: 2,
      cohort_year: 3,
      team_affiliation: "Team Affiliation",
      profession_title: "Profession Title",
      availability: false,
      email: "Email",
      phone_number: "Phone Number",
      biography: "Biography"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Team Affiliation/)
    expect(rendered).to match(/Profession Title/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Biography/)
  end
end
