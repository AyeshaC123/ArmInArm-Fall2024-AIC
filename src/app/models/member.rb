
 # Project name: Arm in Arm Project Team 12
 # Description of Project: The Arm in Arm Project aims to develop an application that assits its clients in need of food
 # Filename: member.rb
 # Description: The file defines a model named "Member" with associations and validations for attributes and ensures format constraints are met
 # Last modified on: April 21, 2024





class Member < ApplicationRecord
  belongs_to :household

  # Add validations or associations as needed
  # validates :firstname, presence: {message: "cannot be blank" }, format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters and spaces" }
  validates :firstname, presence: { message: :blank }, format: { with: /\A[a-zA-Z\s]+\z/, message: :only_letters_and_spaces }
  # validates :lastname, presence: {message: "cannot be blank" } , format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters and spaces" }
  validates :lastname, presence: { message: :blank } , format: { with: /\A[a-zA-Z\s]+\z/, message: :only_letters_and_spaces }
  # validates :dob, presence: { message: "must be selected"}
  validates :dob, presence: { message: :selected }
  # validates :relationship, presence: { message: "must be selected"}
  validates :relationship, presence: { message: :selected }

  # validates :household_id (temporary)
  # validates :household_id, presence: {message: :blank } , numericality: { only_integer: true, greater_than_or_equal_to: 0, message: :greater_than_or_equal_to }
  
  # james: Commented this out, was throwing errors when it shouldn't have

end
