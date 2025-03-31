require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { create(:user, isAdmin: true) } # Assuming Devise + FactoryBot
  let(:user) { create(:user, isAdmin: false) }

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
  end
end
