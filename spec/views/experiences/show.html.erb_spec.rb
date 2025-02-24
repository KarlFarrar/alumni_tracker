require 'rails_helper'

RSpec.describe "experiences/show", type: :view do
  before(:each) do
    assign(:experience, Experience.create!(
      title: "Title",
      type: "Type",
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Type/)
  end
end
