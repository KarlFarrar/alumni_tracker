class Student < ApplicationRecord
  # log all activities.
  include Loggable

  # Belongs to the User 
  belongs_to :user, foreign_key: 'uin', primary_key: 'uin', dependent: :destroy

  accepts_nested_attributes_for :user
end
