require 'rails_helper'

RSpec.describe "Navbar", type: :system do
  before do
    driven_by(:rack_test)
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  it "redirects to the alumni directory when navbar button is clicked" do
    visit root_path
    click_link "Alumni Directory"
    expect(page).to have_current_path(root_path)
  end

  it "redirects to the student directory when navbar button is clicked" do
    visit root_path
    click_link "Student Directory"
    expect(page).to have_current_path(student_directory_path)
  end

  context "When a user IS AN Admin" do 
	let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456734, isAdmin: true) }
	  let(:alumnus) {
	    Alumnus.create!(
	      uin: 123456734,
	      cohort_year: 2024,
	      team_affiliation: "MyString",
	      profession_title: "MyString",
	      availability: false,
	      email: "MyString",
	      phone_number: "(682)-472-8670",
	      LinkedIn: "MyString",
	      user: user
	    )
	  }
	   let(:gmail) {
    	Gmail.create!(email: "test@example.com", user: user, avatar_url: "https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g")
  		}

  	before do
	  allow_any_instance_of(ApplicationController).to receive(:current_gmail).and_return(gmail)
	end

  	it "should show the Admin Access button" do 

		  visit root_path

		  expect(page).to have_button("Admin View")
  	end

  	it "redirects to the admin page when navbar button is clicked" do
 		visit root_path
 		click_link "Admin View"

    	expect(page).to have_current_path(admin_dashboard_path)
  	end


  end

  context "When a user IS AN Admin" do 
  	it "should show the Admin Access button" do 
  		  let(:user) { User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: 123456734, isAdmin: false) }
		  let(:alumnus) {
		    Alumnus.create!(
		      uin: 123456734,
		      cohort_year: 2024,
		      team_affiliation: "MyString",
		      profession_title: "MyString",
		      availability: false,
		      email: "MyString",
		      phone_number: "(682)-472-8670",
		      LinkedIn: "MyString",
		      user: user
		    )
		  }
		  let(:gmail) {
	    	Gmail.create!(email: "test@example.com", user: user, avatar_url: "https://lh3.googleusercontent.com/a/ACg8ocKmuBbupm_fHr6Cj2dthGIeHVbsXLa1jyMDZofvOSmIsN-X2g")
	  	  }

	  	  before do
			  allow_any_instance_of(ApplicationController).to receive(:current_gmail).and_return(gmail)
		  end

		  visit root_path

		  expect(page).not_to have_button("Admin View")
  	end
  end
end