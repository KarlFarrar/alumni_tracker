require 'rails_helper'

RSpec.describe "alumni/show", type: :view do
  before do
    alumnus = assign(:alumnus, Alumnus.create!(uin: "123456789", email: "test@example.com"))
    experience = Experience.create!(title: "Best Developer", experience_type: "Award")
    assign(:alumnus_experiences, [
      AlumnusExperience.create!(
        alumnus: alumnus, 
        experience: experience, 
        date_received: "2021-01-01", 
        custom_description: "Won award")
    ])
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to have_text("123456789")
    expect(rendered).to have_text("test@example.com")
    expect(rendered).to have_text("Best Developer (Award)")
    expect(rendered).to have_text("2021")
  end
end
