class Experience < ApplicationRecord
    belongs_to :alumnus, foreign_key: "recepient_uin", primary_key: "uin", optional: true
  
    validates :title, presence: true
    validates :experience_type, presence: true  # Updated from 'type'
    validates :date_interval, presence: true
    validates :description, presence: true
    validates :recepient_uin, presence: true, numericality: { only_integer: true }
  end
  