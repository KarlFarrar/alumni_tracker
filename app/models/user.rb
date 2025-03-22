class User < ApplicationRecord
  has_one :gmail, primary_key: 'uin', foreign_key: 'uin', dependent: :destroy
  has_one :alumnus, primary_key: 'uin', foreign_key: 'uin', dependent: :destroy


  accepts_nested_attributes_for :gmail

  validates :middle_initial, length: { maximum: 1 }, allow_blank: true

  def uin_data
    uin.presence
  end
  
    # Setting the primary key to match your schema
    self.primary_key = 'uin'
    
    # Validations
    validates :first_name, :last_name, presence: true
    validates :uin, presence: true, numericality: { only_integer: true }, length: { is: 9 },
                uniqueness: true

def uin_changed?
  # Returns true if the uin field was modified
  self.uin_changed? && self.new_record?
end
    attr_readonly :uin
    
    # Default values are defined in the schema
    # default values: middle_initial default: "", status default: "", isAdmin default: false
    
    # Helper methods
    def full_name
      if middle_initial.present?
        "#{first_name} #{middle_initial}. #{last_name}"
      else
        "#{first_name} #{last_name}"
      end
    end
    
    def admin?
      isAdmin == true
    end
    
    # You might want to add associations here if users are related to other models
    # For example:
    # has_many :alumnus_experiences
    # has_many :experiences, through: :alumnus_experiences
  end
