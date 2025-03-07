require 'rails_helper'

RSpec.describe "experiences/index", type: :view do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  before do
    assign(:experiences, [
      Experience.create!(title: "Title1", experience_type: "Certification"),
      Experience.create!(title: "Title2", experience_type: "Award")
    ])
  end

  it "renders a list of experiences" do
    render
    expect(rendered).to have_text("Title1")
    expect(rendered).to have_text("Title2")
  end
end
