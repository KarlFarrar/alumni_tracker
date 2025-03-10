class Experience < ApplicationRecord
  has_many :alumnus_experiences, dependent: :destroy
  has_many :alumni, through: :alumnus_experiences

  validates :title, presence: true
  validates :experience_type, presence: true
  
  belongs_to :alumnus, foreign_key: "recepient_uin", primary_key: "uin", optional: true
end
  
