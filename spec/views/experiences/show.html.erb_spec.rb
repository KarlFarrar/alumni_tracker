require 'rails_helper'

RSpec.describe "experiences/show", type: :view do
  before do
    assign(:experience, Experience.create!(title: "Best Developer", experience_type: "Award")) # ✅ Removed `date_interval`
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to have_text("Best Developer (Award)")
  end
end
