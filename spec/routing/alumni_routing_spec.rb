require "rails_helper"

RSpec.describe AlumniController, type: :routing do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  describe "routing" do
    it "routes to #index" do
      expect(get: "/alumni").to route_to("alumni#index")
    end

    it "routes to #new" do
      expect(get: "/alumni/new").to route_to("alumni#new")
    end

    it "routes to #show" do
      expect(get: "/alumni/1").to route_to("alumni#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/alumni/1/edit").to route_to("alumni#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/alumni").to route_to("alumni#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/alumni/1").to route_to("alumni#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/alumni/1").to route_to("alumni#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/alumni/1").to route_to("alumni#destroy", id: "1")
    end
  end
end
