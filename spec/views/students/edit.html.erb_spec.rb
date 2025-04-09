require 'rails_helper'

RSpec.describe "students/edit", type: :view do
  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456789, isAdmin: false) }
  let(:student) {
    Student.create!(
      uin: 123456789,
      classification: "Freshman",
      major: "MyString",
      resumelink: "MyString",
      email: "MyString",
      phone: "(123)-123-1234",
      linkedin: "MyString",
      user: user
    )
  }

  before(:each) do
    assign(:student, student)
  end

  it "renders the edit student form" do
    render

    assert_select "form[action=?][method=?]", student_path(student), "post" do

      assert_select "input[name=?]", "student[user_attributes][uin]"

      assert_select "select[name=?]", "student[classification]"

      assert_select "input[name=?]", "student[major]"

      assert_select "input[name=?]", "student[resumelink]"

      assert_select "input[name=?]", "student[email]"

      assert_select "input[name=?]", "student[phone]"

      assert_select "input[name=?]", "student[linkedin]"
    end
  end
end
