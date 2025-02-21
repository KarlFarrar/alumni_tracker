class Alumnus < ApplicationRecord
  # log all activities.
  include Loggable

  
  # Relationship to experience. 
  has_many :alumnus_experiences, dependent: :destroy
  has_many :experiences, through: :alumnus_experiences
  
  accepts_nested_attributes_for :experiences, allow_destroy: true
  
  # Relationship to experience. 
  has_many :experiences, foreign_key: "recepient_uin", primary_key: "uin", dependent: :destroy

  accepts_nested_attributes_for :experiences, allow_destroy: true
  
  # Ensure UIN is exactly 9 digits
  validates :uin, format: {
    with: /\A\d{9}\z/,
    message: "must be exactly 9 digits"
  }

  # Ensure the user provides at least one: phone number OR email
  validate :phone_or_email_present

  # Ensure phone number follows (###)-###-####
  validates :phone_number, format: {
    with: /\A\(\d{3}\)-\d{3}-\d{4}\z/,
    message: "must be in the format (###)-###-####"
  }, allow_blank: true  # Allows blank values so it doesn't interfere with phone_or_email_present

  # Format phone number before validating
  before_validation :format_phone_number

private

  def phone_or_email_present
    if phone_number.blank? && email.blank?
      errors.add(:base, "You must provide either a phone number or an email.")
    end
  end

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
