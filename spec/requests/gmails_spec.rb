require 'rails_helper'

RSpec.describe "Gmails::OmniauthCallbacks", type: :controller do
  let!(:gmail_user) { Gmail.create(email: "testuser@example.com", uid: "123456", full_name: "Test User", avatar_url: "test.jpg") }

  before do
    request.env["devise.mapping"] = Devise.mappings[:gmail]
    request.env["omniauth.auth"] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        email: 'testuser@example.com',
        full_name: 'Test User',
        image: 'test.jpg'
      }
    })
  end

  describe "Google OAuth2 login" do
    context "when the user exists" do
      it "logs in and redirects to the root path" do
        post gmail_google_oauth2_omniauth_callback_path
        expect(controller.current_gmail).to eq(gmail_user)
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq(I18n.t('devise.omniauth_callbacks.success', kind: 'Google'))
      end
    end

    context "when the user does not exist" do
      before do
        request.env["omniauth.auth"].info.email = "newuser@example.com"
        request.env["omniauth.auth"].uid = "654321"
      end

      it "redirects to the sign-up page" do
        post gmail_google_oauth2_omniauth_callback_path
        expect(response).to redirect_to(choose_role_registration_path)
        expect(flash[:alert]).to eq("No account found. Please create an account")
      end
    end
  end
end
