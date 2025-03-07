require 'rails_helper'

RSpec.describe "experiences/new", type: :view do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
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
