require 'rails_helper'

RSpec.describe "alumni/show", type: :view do
  before(:each) do
    alumnus = assign(:alumnus, Alumnus.create!(
      uin: "123456789",
      cohort_year: 2021, 
      team_affiliation: "Team Affiliation",
      profession_title: "Profession Title",
      availability: false,
      email: "test@example.com",
      phone_number: "(682)-472-8670",
      biography: "Biography"
    ))

    experience = Experience.create!(title: "Best Developer", experience_type: "Award")
    AlumnusExperience.create!(
      alumnus: alumnus,
      experience: experience,
      date_received: "2021-01-01",
      custom_description: "Won award"
    )
  end

  it "renders alumnus details correctly" do
    render
    expect(rendered).to have_text("123456789")
    expect(rendered).to have_text("2021")
    expect(rendered).to have_text("Team Affiliation")
    expect(rendered).to have_text("Profession Title")
    expect(rendered).to have_text("test@example.com")
    expect(rendered).to match(/\(682\)-472-8670/) 
    expect(rendered).to have_text("Biography")
  end

  it "renders experiences correctly" do
    render
    expect(rendered).to have_text("Best Developer (Award)")
    expect(rendered).to have_text("Date Received: 2021-01-01") 
    expect(rendered).to have_text("Won award")
  end

  it "renders the claim experience modal" do
    render
    expect(rendered).to have_selector("div#claim_experience_modal")
    expect(rendered).to have_selector("input#modal_experience_id", visible: false)
    expect(rendered).to have_selector("input[name='date_received']")
    expect(rendered).to have_selector("textarea[name='custom_description']")
  end

  it "renders a remove experience button" do
    render
    expect(rendered).to have_selector("a.btn.btn-danger", text: "Remove")
  end

end
