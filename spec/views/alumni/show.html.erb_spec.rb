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
    expect(rendered).to match(/123456789/)
    expect(rendered).to match(/2021/)
    expect(rendered).to match(/Team Affiliation/)
    expect(rendered).to match(/Profession Title/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/(682)-472-8670/)
    expect(rendered).to match(/Biography/)
  end
end
