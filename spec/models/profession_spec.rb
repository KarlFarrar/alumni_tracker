require 'rails_helper'

RSpec.describe Profession, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end

  describe "associations" do
    it { is_expected.to have_many(:alumnus_professions) }
    it { is_expected.to have_many(:alumni).through(:alumnus_professions) }
  end
end
