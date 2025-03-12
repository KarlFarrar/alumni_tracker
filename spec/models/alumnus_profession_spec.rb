require 'rails_helper'

RSpec.describe AlumnusProfession, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:alumnus) }
    it { is_expected.to belong_to(:profession) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:field) }
  end
end
