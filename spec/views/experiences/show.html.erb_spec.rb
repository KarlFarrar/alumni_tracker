require 'rails_helper'

RSpec.describe "experiences/show", type: :view do
  before(:each) do
    assign(:experience, Experience.create!(
      title: "Title",
      type: "Type",
      date_interval: "Date Interval",
      description: "MyText",
      recepient_uin: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Date Interval/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
