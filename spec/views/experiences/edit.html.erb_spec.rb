require 'rails_helper'

RSpec.describe "experiences/edit", type: :view do
  let(:experience) {
    Experience.create!(
      title: "MyString",
      type: "Award",
    )
  }

  before(:each) do
    assign(:experience, experience)
  end

  it "renders the edit experience form" do
    render

    assert_select "form[action=?][method=?]", experience_path(experience), "post" do

      assert_select "input[name=?]", "experience[title]"

      assert_select "input[name=?]", "experience[type]"
    end
  end
end
