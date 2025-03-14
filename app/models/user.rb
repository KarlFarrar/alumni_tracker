class User < ApplicationRecord
  has_one :gmail, foreign_key: 'uin', dependent: :destory
  has_one :alumnus, foreign_key: 'uin', dependent: :destroy

  accepts_nested_attributes_for :alumnus
  accepts_nested_attributes_for :gmail

  validates :uin, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :middle_initial, length: { maximum: 1 }, allow_blank: true
end