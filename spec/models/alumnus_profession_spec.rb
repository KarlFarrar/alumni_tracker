require 'rails_helper'

RSpec.describe AlumnusProfession, type: :model do
  describe "associations" do
    it { should belong_to(:alumnus) }
    it { should belong_to(:profession) }
  end

  describe "validations" do
    it { should validate_presence_of(:field) }
  end
end
