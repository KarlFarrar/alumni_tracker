require 'rails_helper'

RSpec.describe "experiences/index", type: :view do
  before(:each) do
    assign(:experiences, [
      Experience.create!(
        title: "Title",
        type: "Type",
        date_interval: "Date Interval",
        description: "MyText",
        recepient_uin: 2
      )
    ])
  end

  it "renders a list of experiences" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s)
    assert_select cell_selector, text: Regexp.new("Type".to_s)

  end
end
