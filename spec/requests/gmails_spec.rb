require 'rails_helper'

RSpec.describe "Gmails::OmniauthCallbacks", type: :system do
  before do 
    driven_by(:rack_test)

    OmniAuth.config.test_mode = true
  end 

  context "when the user exists" do 
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        email: 'testuser@example.com',
        name: 'Test user',
        image: 'https://example.com/avatar.jpg'
      },
      credentials: {
        token: 'mock_token',
        expires_at: Time.now + 1.week
      }
    })
    # @user = User.create!(first_name: "test_first", last_name: "test_last", middle_initial: "a", uin: "123456789")
    @gmail = Gmail.create!(
      email: 'testuser@example.com',
      uid: '123456',
      avatar_url: 'https://example.com/avatar.jpg'
      # user: @user
    )
    end

    it 'saves & goes to root node' do
    visit '/gmails/auth/google_oauth2/callback'

    expect(page).to have_current_path(root_path)
    end  
  end 

  context "When user does not exist" do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '654321',
      info: {
        email: 'newuser@example.com',
        name: 'New user',
        image: 'https://example.com/newavatar.jpg'
      },
      credentials: {
        token: 'mock_token',
        expires_at: Time.now + 1.week
      }
    })
    end 

    it 'redirects to redirects to choose_role_registration_path' do
      visit '/gmails/auth/google_oauth2/callback'
      expect(page).to have_current_path(choose_role_registration_path)
    end  
  end
end
