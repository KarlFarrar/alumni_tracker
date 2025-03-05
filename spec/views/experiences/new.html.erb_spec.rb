require 'rails_helper'

RSpec.describe "experiences/new", type: :view do
  before do
    assign(:experience, Experience.new(title: "MyString", experience_type: "Award"))
  end

  it "renders new experience form" do
    render

    assert_select "form[action=?][method=?]", experiences_path, "post" do
      assert_select "input[name=?]", "experience[title]"
      assert_select "input[name=?]", "experience[experience_type]"
    end
  end
end
