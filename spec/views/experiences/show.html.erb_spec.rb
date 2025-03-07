require 'rails_helper'

RSpec.describe "experiences/show", type: :view do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  before do
    assign(:experience, Experience.create!(title: "Best Developer", experience_type: "Award")) # ✅ Removed `date_interval`
  end

  it "renders the experience details inside a div with correct ID" do
    render

    experience = assigns(:experience)

    expect(rendered).to have_selector("div##{dom_id(experience)}")
    expect(rendered).to have_selector("strong", text: "Title:")
    expect(rendered).to have_text("Best Developer")
    expect(rendered).to have_selector("strong", text: "Type:")
    expect(rendered).to have_text("Award")
  end
end
