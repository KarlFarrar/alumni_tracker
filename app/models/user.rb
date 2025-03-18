class User < ApplicationRecord
  has_one :gmail, primary_key: 'uin', foreign_key: 'uin', dependent: :destroy
  has_one :alumnus, primary_key: 'uin', foreign_key: 'uin', dependent: :destroy


  accepts_nested_attributes_for :gmail

  validates :uin, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :middle_initial, length: { maximum: 1 }, allow_blank: true

  def uin_data
    uin.presence
  end
  
end