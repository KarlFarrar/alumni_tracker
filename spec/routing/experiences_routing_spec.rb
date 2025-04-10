require "rails_helper"

RSpec.describe ExperiencesController, type: :routing do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end
  describe "routing" do
    it "routes to #index" do
      expect(get: "/experiences").to route_to("experiences#index")
    end

    it "routes to #new" do
      expect(get: "/experiences/new").to route_to("experiences#new")
    end

    it "routes to #show" do
      expect(get: "/experiences/1").to route_to("experiences#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/experiences/1/edit").to route_to("experiences#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/experiences").to route_to("experiences#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/experiences/1").to route_to("experiences#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/experiences/1").to route_to("experiences#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/experiences/1").to route_to("experiences#destroy", id: "1")
    end
  end
end
