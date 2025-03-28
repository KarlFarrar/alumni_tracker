require 'rails_helper'

RSpec.describe "students/edit", type: :view do
  let(:student) {
    Student.create!(
      uin: 1,
      classification: "MyString",
      major: "MyString",
      resumelink: "MyString",
      email: "MyString",
      phone: "MyString",
      biography: "MyString"
    )
  }

  before(:each) do
    assign(:student, student)
  end

  it "renders the edit student form" do
    render

    assert_select "form[action=?][method=?]", student_path(student), "post" do

      assert_select "input[name=?]", "student[uin]"

      assert_select "input[name=?]", "student[classification]"

      assert_select "input[name=?]", "student[major]"

      assert_select "input[name=?]", "student[resumelink]"

      assert_select "input[name=?]", "student[email]"

      assert_select "input[name=?]", "student[phone]"

      assert_select "input[name=?]", "student[biography]"
    end
  end
end
