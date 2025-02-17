class Alumnus < ApplicationRecord
    # Ensure UIN is 9 digits
    validates :uin, format: { 
        with: /\A\d{9}\z/, 
        message: "must be exactly 9 digits" 
    }

    # Ensure phone number follows (###)-###-####
    validates :phone_number, format: { 
      with: /\A\(\d{3}\)-\d{3}-\d{4}\z/, 
      message: "must be in the format (###)-###-####" 
    }
  
    # Automatically format phone number before saving
    before_save :format_phone_number
  
    private
  
    def format_phone_number
      return if phone_number.blank?
  
      # Remove all non-numeric characters
      digits = phone_number.gsub(/\D/, "")
  
      # Ensure it's exactly 10 digits before formatting
      if digits.length == 10
        self.phone_number = "(#{digits[0..2]})-#{digits[3..5]}-#{digits[6..9]}"
      end
    end
end
  