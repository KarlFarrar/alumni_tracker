class StudentExperience < ApplicationRecord
    belongs_to :student
    belongs_to :experience
  
    validates :date_received, presence: true
    validates :student_id, presence: true
    validates :experience_id, presence: true
    validates :custom_description, length: { maximum: 500 }
    validates :placement, presence: true, if: -> { experience&.experience_type == "Competition" }
end
