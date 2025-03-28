require 'rails_helper'

RSpec.describe "students/index", type: :view do
  before(:each) do
    assign(:students, [
      Student.create!(
        uin: 2,
        classification: "Classification",
        major: "Major",
        resumelink: "Resumelink",
        email: "Email",
        phone: "Phone",
        biography: "Biography"
      ),
      Student.create!(
        uin: 2,
        classification: "Classification",
        major: "Major",
        resumelink: "Resumelink",
        email: "Email",
        phone: "Phone",
        biography: "Biography"
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
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Biography".to_s), count: 2
  end
end
