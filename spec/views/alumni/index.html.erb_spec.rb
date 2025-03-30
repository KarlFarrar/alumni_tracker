require 'rails_helper'

RSpec.describe "alumni/index", type: :view do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456789) }

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
        biography: "Biography",
        user: user
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
    assert_select cell_selector, text: /Email/, count: 1
    assert_select cell_selector, text: /\(682\)-472-8670/, count: 1
    assert_select cell_selector, text: /Biography/, count: 1
  end
end
