require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  let(:admin) {
    User.create!(
      email: "admin@example.com",
      password: "password",
      password_confirmation: "password",
      isAdmin: true
    )
  }

  let(:user) {
    User.create!(
      email: "user@example.com",
      password: "password",
      password_confirmation: "password",
      first_name: "Test",
      isAdmin: false
    )
  }

  before do
    sign_in admin  # 👈 Sign in the admin before each request
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
  end
end
