require 'rails_helper'

RSpec.describe "alumni/index", type: :view do
  before(:each) do
    assign(:alumni, [
      Alumnus.create!(
        uin: 123456789,
        cohort_year: 2021,
        team_affiliation: "Team Affiliation",
        profession_title: "Profession Title",
        availability: false,
        email: "Email",
        phone_number: "6824728670",
        biography: "Biography"
      ),
      Alumnus.create!(
        uin: 123456789,
        cohort_year: 2021,
        team_affiliation: "Team Affiliation",
        profession_title: "Profession Title",
        availability: false,
        email: "Email",
        phone_number: "6824728670",
        biography: "Biography"
      )
    ])
  end

  it "renders a list of alumni" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Team Affiliation".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Profession Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Biography".to_s), count: 2
  end
end
