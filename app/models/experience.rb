class Experience < ApplicationRecord
  include Loggable
  has_many :alumnus_experiences, dependent: :destroy
  has_many :alumni, through: :alumnus_experiences

  has_many :student_experiences, dependent: :destroy
  has_many :students, through: :student_experiences

  validates :title, presence: true
  validates :experience_type, presence: true
end

