class Experience < ApplicationRecord
  has_many :alumnus_experiences, dependent: :destroy
  has_many :alumni, through: :alumnus_experiences

  validates :title, presence: true
  validates :experience_type, presence: true  # Updated from 'type'
  validates :date_interval, presence: true
  validates :description, presence: true
  validates :recepient_uin, presence: true, numericality: { only_integer: true }
end