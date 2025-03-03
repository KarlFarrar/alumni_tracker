require 'rails_helper'
  Rspec.describe "gmails", type: :request do 
    let!(:gmail_user) do 
	  Gmail.create!(
	    email: 'testuser@example.com'
		uid: '12345'
		full_name: 'Test User'
	  )
	end 

	describe "Post /google_oauth2" do
		context "when the user exists" do 
			it "sign in user and redirects to home page" do
				auth = OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
					provider: 'google_oauth2'
					uid: '12345'
					info: {email: 'testuser@example.com', full_name: 'Test User'}
				})

				post "/gmails/auth.google_oauth2", params: {omniauth: auth}

				expect(response).to redirect_to(root_path)
				follow_redirect!
			end 
		end

		context "when user does not exist" do 
			it "redirects them to create account screen" do 
				auth = OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
					provider: 'google_oauth2'
					uid: '654321'
					info: {email: 'newuser@example.com', full_name: 'New User'}
				})
			end

			post "/gmails/auth.google_oauth2", params: {omniauth: auth}

			expect(response).to redirect_to(root_path)
			follow_redirect!

		end
	end 
  end 
end