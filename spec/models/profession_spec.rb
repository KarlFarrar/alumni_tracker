require 'rails_helper'

RSpec.describe Profession, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  describe 'associations' do
    it { should have_many(:alumnus_professions) }
    it { should have_many(:alumni).through(:alumnus_professions) }
  end
end
