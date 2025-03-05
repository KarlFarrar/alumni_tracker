class Experience < ApplicationRecord
  has_many :alumnus_experiences, dependent: :destroy
  has_many :alumni, through: :alumnus_experiences

  validates :title, presence: true
  validates :experience_type, presence: true
end