require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do

    before do
        # This will skip the `authenticate_gmails!` before action
        allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
    end
    let(:admin) {
        User.create!(
        uin: 111222333,
        first_name: "Admin",
        last_name: "Test",
        status: "student",
        isAdmin: true,
        )
    }

    let(:user) {
        User.create!(
        uin: 333222111,
        first_name: "User",
        last_name: "Testee",
        status: "student",
        isAdmin: false
        )
    }

    describe "POST /admin/users/:id/give_admin" do
        context "when the user exists and is not an admin" do
            it "grants admin privileges to the user" do
                post give_admin_admin_user_path(user)

                expect(response).to redirect_to(admin_users_path)
                follow_redirect!

                expect(flash[:notice]).to eq("#{user.first_name} was given admin privileges.")
                expect(user.reload.isAdmin).to be true
            end
        end
    end
end
