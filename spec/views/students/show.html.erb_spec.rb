require 'rails_helper'

RSpec.describe "students/show", type: :view do
  before(:each) do
    assign(:student, Student.create!(
      uin: 2,
      classification: "Classification",
      major: "Major",
      resumelink: "Resumelink",
      email: "Email",
      phone: "Phone",
      biography: "Biography"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Classification/)
    expect(rendered).to match(/Major/)
    expect(rendered).to match(/Resumelink/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Biography/)
  end
end
