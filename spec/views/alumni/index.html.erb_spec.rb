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
        phone_number: "(682)-472-8670",
        biography: "Biography"
      )
    ])
  end

  it "renders a list of alumni" do
    render
    cell_selector = 'div>p'

    assert_select cell_selector, text: /123456789/, count: 1
    assert_select cell_selector, text: /2021/, count: 1
    assert_select cell_selector, text: /Team Affiliation/, count: 1
    assert_select cell_selector, text: /Profession Title/, count: 1
    assert_select cell_selector, text: /false/, count: 1
    assert_select cell_selector, text: /Email/, count: 1
    assert_select cell_selector, text: /\(682\)-472-8670/, count: 1
    assert_select cell_selector, text: /Biography/, count: 1
   
  end
end
