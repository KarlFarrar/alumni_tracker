require 'rails_helper'

RSpec.describe "students/index", type: :view do

  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456789, isAdmin: false) }
  let(:user2) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456788, isAdmin: false) }


  before(:each) do
    assign(:students, [
      Student.create!(
        uin: 123456789,
        classification: "Classification",
        major: "Major",
        resumelink: "Resumelink",
        email: "Email",
        phone: "(123)-123-1234",
        linkedin: "LinkedIn",
        user: user
      ),
      Student.create!(
        uin: 123456788,
        classification: "Classification",
        major: "Major",
        resumelink: "Resumelink",
        email: "Email",
        phone: "(123)-123-1234",
        linkedin: "LinkedIn",
        user: user2
      )
    ])
  end

  it "renders a list of students" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 4
    assert_select cell_selector, text: Regexp.new("Classification".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Major".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Resumelink".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select 'div>p', text: /\(\d{3}\)-\d{3}-\d{4}/, count: 2
    assert_select cell_selector, text: Regexp.new("LinkedIn".to_s), count: 2
  end
end
