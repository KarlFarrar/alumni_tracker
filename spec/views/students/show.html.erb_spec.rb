require 'rails_helper'

RSpec.describe "students/show", type: :view do

  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456789) }


  before(:each) do
    assign(:student, Student.create!(
      uin: 123456789,
      classification: "Classification",
      major: "Major",
      resumelink: "Resumelink",
      email: "Email",
      phone: "(123)-123-1234",
      biography: "Biography",
      user: user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Classification/)
    expect(rendered).to match(/Major/)
    expect(rendered).to match(/Resumelink/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/\(123\)-123-1234/)
    expect(rendered).to match(/Biography/)
  end
end
