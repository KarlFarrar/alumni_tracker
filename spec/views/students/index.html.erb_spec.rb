require 'rails_helper'

RSpec.describe "students/index", type: :view do

  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456789) }
  let(:user2) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456788) }


  before(:each) do
    assign(:students, [
      Student.create!(
        uin: 123456789,
        classification: "Classification",
        major: "Major",
        resumelink: "Resumelink",
        email: "Email",
        phone: "(123)-123-1234",
        biography: "Biography",
        user: user
      ),
      Student.create!(
        uin: 123456788,
        classification: "Classification",
        major: "Major",
        resumelink: "Resumelink",
        email: "Email",
        phone: "(123)-123-1234",
        biography: "Biography",
        user: user2
      )
    ])
  end

  it "renders a list of students" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Classification".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Major".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Resumelink".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("(123)-123-1234".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Biography".to_s), count: 2
  end
end
