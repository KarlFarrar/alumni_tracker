class AlumnusProfession < ApplicationRecord
  belongs_to :alumnus
  belongs_to :profession

  validates :field, presence: true
end
