require 'rails_helper'

RSpec.describe "experiences/new", type: :view do
  before(:each) do
    assign(:experience, Experience.new(
      title: "MyString",
      type: "",
      date_interval: "MyString",
      description: "MyText",
      recepient_uin: 1
    ))
  end

  it "renders new experience form" do
    render

    assert_select "form[action=?][method=?]", experiences_path, "post" do

      assert_select "input[name=?]", "experience[title]"

      assert_select "input[name=?]", "experience[type]"

      assert_select "input[name=?]", "experience[date_interval]"

      assert_select "textarea[name=?]", "experience[description]"

      assert_select "input[name=?]", "experience[recepient_uin]"
    end
  end
end
