require 'rails_helper'

RSpec.describe "Navbar", type: :system do

  before do
    driven_by(:rack_test)
    #allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
    OmniAuth.config.test_mode = true
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  context "When a user IS AN Admin" do 
  	let(:user) { User.create!(first_name: "Is", last_name: "Admin", uin: 555555555, isAdmin: true) }
    let(:gmail) { Gmail.create!(email: "test@example.com", user: user, avatar_url: "https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g") }
	before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        email: 'testuser@example.com',
        name: 'Test user',
        image: 'https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g'
      },
      credentials: {
        token: 'mock_token',
        expires_at: Time.now + 1.week
      }
    })
      allow_any_instance_of(ApplicationController).to receive(:current_gmail).and_return(gmail)
      visit root_path
    end

    it "redirects to the alumni directory when navbar button is clicked" do
	    click_button "Alumni Directory"
	    expect(page).to have_current_path(root_path)
	end

	it "redirects to the student directory when navbar button is clicked" do
	    click_button "Student Directory"
	    expect(page).to have_current_path(student_directory_path)
	end

  	it "redirects to the admin page when navbar button is clicked" do
 		visit root_path
 		click_button "Admin View"

    	expect(page).to have_current_path(admin_dashboard_path)
  	end


  end

  context "When a user IS AN Admin" do 
  	let(:user) { User.create!(first_name: "Non", last_name: "Admin", uin: 555555556, isAdmin: false) }
    let(:gmail) { Gmail.create!(email: "test@example.com", user: user, avatar_url: "https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g") }
	before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123457',
      info: {
        email: 'testuser@example.com',
        name: 'Test user',
        image: 'https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g'
      },
      credentials: {
        token: 'mock_token',
        expires_at: Time.now + 1.week
      }
    })
      allow_any_instance_of(ApplicationController).to receive(:current_gmail).and_return(gmail)
      visit root_path
    end

	it "should show the Admin Access button" do 
		  expect(page).not_to have_button("Admin View")
  	end
  end
end