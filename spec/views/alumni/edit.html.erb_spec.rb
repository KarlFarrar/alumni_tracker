require 'rails_helper'

RSpec.describe "alumni/edit", type: :view do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  let(:alumnus) {
    Alumnus.create!(
      uin: 123456789,
      cohort_year: 2024,
      team_affiliation: "MyString",
      profession_title: "MyString",
      availability: false,
      email: "MyString",
      phone_number: "(682)-472-8670",
      biography: "MyString"
    )
  }

  before(:each) do
    assign(:alumnus, alumnus)
  end

  it "renders the edit alumnus form" do
    render

    assert_select "form[action=?][method=?]", alumnus_path(alumnus), "post" do
      assert_select "input[name=?]", "alumnus[uin]"
      assert_select "select[name=?]", "alumnus[cohort_year]"
      assert_select "input[name=?]", "alumnus[team_affiliation]"
      assert_select "input[name=?]", "alumnus[profession_title]"
      assert_select "input[name=?]", "alumnus[availability]"
      assert_select "input[name=?]", "alumnus[email]"
      assert_select "input[name=?]", "alumnus[phone_number]"
      assert_select "input[name=?]", "alumnus[biography]"
    end
  end
end
