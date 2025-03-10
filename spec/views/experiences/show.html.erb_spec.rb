require 'rails_helper'

RSpec.describe "experiences/show", type: :view do
  before do
    assign(:experience, Experience.create!(title: "Best Developer", experience_type: "Award"))
  end

  it "renders the experience details inside a div with correct ID" do
    render

    expect(rendered).to have_selector("div", text: "Best Developer")  
    expect(rendered).to have_selector("strong", text: "Title:")
    expect(rendered).to have_text("Best Developer")
    expect(rendered).to have_selector("strong", text: "Type:")
    expect(rendered).to have_text("Award")
  end
end
