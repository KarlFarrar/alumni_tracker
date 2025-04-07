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
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        email: 'Email',
        name: 'Test user',
        image: 'https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g'
      },
      credentials: {
        token: 'mock_token',
        expires_at: Time.now + 1.week
      }
    })
      allow_any_instance_of(ApplicationController).to receive(:current_gmail).and_return(gmail)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Classification/)
    expect(rendered).to match(/Major/)
    expect(rendered).to match(/Resumelink/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/\(123\)-123-1234/)
    expect(rendered).to match(/LinkedIn/)
  end
end
