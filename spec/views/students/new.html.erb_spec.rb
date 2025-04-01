require 'rails_helper'

RSpec.describe "students/new", type: :view do

  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456789) }

  before(:each) do
    assign(:student, Student.new(
      uin: 123456789,
      classification: "MyString",
      major: "MyString",
      resumelink: "MyString",
      email: "MyString",
      phone: "MyString",
      biography: "MyString",
      user: user
    ))
  end

  it "renders new student form" do
    render

    assert_select "form[action=?][method=?]", students_path, "post" do

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
