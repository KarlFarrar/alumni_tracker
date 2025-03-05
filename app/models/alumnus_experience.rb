class AlumnusExperience < ApplicationRecord
  belongs_to :alumnus
  belongs_to :experience

  validates :date_received, presence: true
  validates :custom_description, length: { maximum: 500 }
end
