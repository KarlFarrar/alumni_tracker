require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { create(:user, isAdmin: true) } # Assuming Devise + FactoryBot
  let(:user) { create(:user, isAdmin: false) }

  before do
    sign_in admin
  end

  describe "POST /admin/users/:id/give_admin" do
    context "when the user exists and is not an admin" do
      it "grants admin privileges to the user" do
        post give_admin_admin_user_path(user)

        expect(response).to redirect_to(admin_users_path)
        follow_redirect!

        expect(response.body).to include("#{user.first_name} was given admin privileges.")
        expect(user.reload.isAdmin).to be true
      end
    end

    context "when the user update fails" do
      before do
        allow_any_instance_of(User).to receive(:update).and_return(false)
      end

      it "redirects with an alert message" do
        post give_admin_admin_user_path(user)

        expect(response).to redirect_to(admin_users_path)
        follow_redirect!

        expect(response.body).to include("Failed to update user.")
      end
    end

    context "when a non-admin user tries to access the route" do
      before do
        sign_out admin
        sign_in user
      end

      it "denies access or redirects" do
        post give_admin_admin_user_path(user)

        expect(response).to have_http_status(:redirect)
        # Adjust this based on how your app handles unauthorized access
      end
    end
  end
end
