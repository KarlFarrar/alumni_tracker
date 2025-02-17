require 'rails_helper'

RSpec.describe "alumni/new", type: :view do
  before(:each) do
    assign(:alumnus, Alumnus.new(
      uin: 1,
      cohort_year: 1,
      team_affiliation: "MyString",
      profession_title: "MyString",
      availability: false,
      email: "MyString",
      phone_number: "MyString",
      biography: "MyString"
    ))
  end

  it "renders new alumnus form" do
    render

    assert_select "form[action=?][method=?]", alumni_path, "post" do

      assert_select "input[name=?]", "alumnus[uin]"

      assert_select "input[name=?]", "alumnus[cohort_year]"

      assert_select "input[name=?]", "alumnus[team_affiliation]"

      assert_select "input[name=?]", "alumnus[profession_title]"

      assert_select "input[name=?]", "alumnus[availability]"

      assert_select "input[name=?]", "alumnus[email]"

      assert_select "input[name=?]", "alumnus[phone_number]"

      assert_select "input[name=?]", "alumnus[biography]"
    end
  end
end
