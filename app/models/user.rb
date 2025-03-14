class User < ApplicationRecord
    # Setting the primary key to match your schema
    self.primary_key = 'uin'
    
    # Validations
    validates :first_name, :last_name, presence: true
    validates :uin, presence: true, uniqueness: true, numericality: { only_integer: true }
    
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