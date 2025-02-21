require 'rails_helper'

RSpec.describe "experiences/edit", type: :view do
  let(:experience) {
    Experience.create!(
      title: "MyString",
      type: "",
      date_interval: "MyString",
      description: "MyText",
      recepient_uin: 1
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

      assert_select "input[name=?]", "experience[date_interval]"

      assert_select "textarea[name=?]", "experience[description]"

      assert_select "input[name=?]", "experience[recepient_uin]"
    end
  end
end
