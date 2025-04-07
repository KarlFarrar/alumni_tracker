require 'rails_helper'

RSpec.describe "students/show", type: :view do

  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456789, isAdmin: false) }
  let(:gmail) { Gmail.create!(email: "Email", user: user, avatar_url: "https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g") }

  before(:each) do
    assign(:student, Student.create!(
      uin: 123456789,
      classification: "Classification",
      major: "Major",
      resumelink: "Resumelink",
      email: "Email",
      phone: "(123)-123-1234",
      linkedin: "LinkedIn",
      user: user
    ))
      allow(view).to receive(:current_gmail).and_return(gmail)
  end
  # Assuming you're testing for the presence of the resume link
  it "renders the resume link if available" do
    student = create(:student, resumelink: "http://example.com/resume.pdf")
    render template: "students/show", locals: { student: student }
    expect(rendered).to match(/View Resume/)
  end
  # If resumelink is invalid
  it "shows a fallback message if the resume link is invalid" do
    student = create(:student, resumelink: "invalid-url")
    render template: "students/show", locals: { student: student }
    expect(rendered).to match(/No valid resume link available/)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Classification/)
    expect(rendered).to match(/Major/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/\(123\)-123-1234/)
    expect(rendered).to match(/LinkedIn/)
  end
end
