class Profession < ApplicationRecord
    include Loggable
    has_many :alumnus_professions
    has_many :alumni, through: :alumnus_professions

    validates :title, presence: true, uniqueness: { case_sensitive: false }
end
