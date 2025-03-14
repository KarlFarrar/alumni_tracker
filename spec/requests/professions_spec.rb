require 'rails_helper'

RSpec.describe "Professions", type: :request do
  before do
    # This will skip the `authenticate_gmails!` before action
    allow_any_instance_of(ApplicationController).to receive(:authenticate_gmail!).and_return(true)
  end

  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
