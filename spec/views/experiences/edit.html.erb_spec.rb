require 'rails_helper'

RSpec.describe "experiences/edit", type: :view do
  before do
    assign(:experience, Experience.create!(title: "MyString", experience_type: "Award")) 
  end

  it "renders the edit experience form" do
    render

    assert_select "form[action=?][method=?]", experience_path(assigns(:experience)), "post" do
      assert_select "input[name=?]", "experience[title]"
      assert_select "input[name=?]", "experience[experience_type]"
    end
  end
end