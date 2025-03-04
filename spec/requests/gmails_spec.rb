require 'rails_helper'

RSpec.describe "Gmails::OmniauthCallbacks", type: :system do
  before do 
    driven_by(:rack_test)

    Omniauth.config.test_mode = true

    Omniauth.config.mock_auth[:google_oauth2] = Omniauth::AuthHash.new({
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

    @gmail = Gmail.create!(
      email: 'testuser@example.com',
      full_name: 'Test user',
      uid: '123456',
      avatar_url: 'https://example.com/avatar.jpg'
    )
  end

  it 'saves & goes to root node' do
    visit '/gmails/auth/google_oauth2/callback'

    expect(page).to have_current_path(root_path)
  end  
end
