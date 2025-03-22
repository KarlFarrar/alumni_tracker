require 'rails_helper'

RSpec.describe "alumni/new", type: :view do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  before(:each) do
    let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: "123456789") }
    assign(:alumnus, Alumnus.new(
      uin: 123456789,
      cohort_year: 2021,
      team_affiliation: "Team Affiliation",
      profession_title: "Profession Title",
      availability: false,
      email: "Email",
      phone_number: "(682)-472-8670",
      biography: "Biography",
      user: user
    ))
  end

  it "renders new alumnus form" do
    render

    assert_select "form[action=?][method=?]", alumni_path, "post" do
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
