require 'rails_helper'

RSpec.describe "experiences/index", type: :view do
  before do
    assign(:experiences, [
      Experience.create!(title: "Title1", experience_type: "Certification"), 
    ])
  end

  it "renders a list of experiences" do
    render
    expect(rendered).to have_text("Title1")
  end
end
