require 'rails_helper'

RSpec.describe "alumni/show", type: :view do
  before(:each) do
    assign(:alumnus, Alumnus.create!(
      uin: 123456789,
      cohort_year: 2021,
      team_affiliation: "Team Affiliation",
      profession_title: "Profession Title",
      availability: false,
      email: "Email",
      phone_number: "(682)-472-8670",
      biography: "Biography"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to have_text("123456789")
    expect(rendered).to have_text("2021".to_s)
    expect(rendered).to have_text("Team Affiliation")
    expect(rendered).to have_text("Profession Title")
    expect(rendered).to have_text("false")
    expect(rendered).to have_text("Email")
    expect(rendered).to match(/\(682\)-472-8670/)  # Escaped regex for phone number
    expect(rendered).to have_text("Biography")
  end
end
