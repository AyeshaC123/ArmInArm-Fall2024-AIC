
 # Project name: Arm in Arm Project Team 12
 # Description of Project: The Arm in Arm Project aims to develop an application that assits its clients in need of food
 # Filename: household.rb
 # Description: The file defines the Household model, featuring custom validators for household size and head of household age, along with numerous attribute validations and associations with member records
 # Last modified on: April 21, 2024




# app/models/household.rb
# frozen_string_literal: true


# Ensures there aren't too many members in the household
class HouseholdSizeValidator < ActiveModel::Validator
  def validate(record)
    # If any of the fields are nil, we won't add an error here since the presence validations will handle it
    return if record.numadults.nil? || record.numchild.nil?

    # Including the head of the household, the total size should not exceed 7
    if (record.numadults + record.numchild) > 7
      record.errors.add(:base, 'The total number of adults and children must not exceed 7, as the head of the household is already included.')
    end
  end
end

# Ensures the head of household is at least 18 years old
class HeadHouseholdAgeValidator < ActiveModel::Validator
  def validate(record)
    if record.headdob && record.headdob > 18.years.ago
      record.errors.add(:base, 'Must be 18 or older to register.')
    end
  end
end

class Household < ApplicationRecord
  # Validations

  # james: added pantrylocation
  validates :headname, :headdob, :numadults, :numchild, :pantrylocation, :streetaddr, :city, :state, :county, 
            :zipcode, :phonenum, :householdtype, :headgender, :headethnicity, 
            :foodstamps, :incomesource, :qualifiercode, :netincome, presence: true

  validates :headname, format: { with: /\A[a-zA-Z\s-]+\z/, message: 'only allows letters and spaces' }
  validates :numadults, :numchild, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 7 }
  validates :streetaddr, format: { with: /\A[^\-][a-zA-Z0-9\s,.#'-]+\z/, message: 'contains invalid characters' }
  validates :city, format: { with: /\A[a-zA-Z\s]+\z/, message: 'only allows letters and spaces' }
  validates :zipcode, format: { with: /\A\d{5}(-\d{4})?\z/, message: 'must be a valid ZIP code' }
  validates :phonenum, numericality: { only_integer: true }, length: { is: 10, message: 'must be 10 digits long' }
  validates :netincome, numericality: { greater_than_or_equal_to: 0, message: 'must be non-negative' }
  validates :state, :county, presence: { message: 'must be selected' }
  validates :householdtype, :headgender, :headethnicity, :foodstamps, :incomesource, :qualifiercode, 
            presence: { message: 'must be selected' }

#   validates :headname, :numadults, :numchild, :streetaddr, :city,
#             :zipcode, :phonenum, :netincome, presence: { message: :blank }
#   validates :headdob, :pantrylocation, :state, :county, :householdtype, :headgender, :headethnicity,
#             :foodstamps, :incomesource, :qualifiercode, presence: { message: :selected }

#   validates :headname, :city, format: { with: /\A[a-zA-Z\s-]+\z/, message: :only_letters_and_spaces }
#   validates :numadults, :numchild, :netincome, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: :at_least_zero }
#   validates :streetaddr, format: { with: /\A[^\-][a-zA-Z0-9\s,.#'-]+\z/, message: :invalid_chars }
#   validates :zipcode, format: { with: /\A\d{5}(-\d{4})?\z/, message: :only_numbers }
#   validates :phonenum, format: { with: /\A\d{10}\z/, message: :only_numbers }


  # Custom validators
  validates_with HouseholdSizeValidator, HeadHouseholdAgeValidator

  # Associations
  has_many :members, dependent: :destroy #This makes sure that when a household is deleted, all member records are also deleted
  accepts_nested_attributes_for :members
end

#class Household < ApplicationRecord
    #sets flag to false -- only changed when an issue is caught during registration -- Team13 4/24/24

    # Add validations or associations as needed
    # validates :headname, presence: true
    # validates :headdob, presence: true
    # validates :numadults, presence: true
    # validates :numchild, presence: true
    # validates :pantrylocation, presence: true
    # validates :streetaddr, presence: true
    # validates :city, presence: true
    # validates :state, presence: true
    # validates :county, presence: true
    # validates :zipcode, presence: true
    # validates :phonenum, presence: true
    # validates :householdtype, presence: true
    # validates :headgender, presence: true
    # validates :headethnicity, presence: true
    # validates :foodstamps, presence: true
    # validates :incomesource, presence: true
    # validates :qualifiercode, presence: true
    # validates :netincome, presence: true
#collab14-prototype4
#     validates :headname, presence: true
#     validates :headdob, presence: true
#     validates :numadults, presence: true
#     validates :numchild, presence: true
#     validates :streetaddr, presence: true
#     validates :city, presence: true
#     validates :state, presence: true
#     validates :county, presence: true
#     validates :zipcode, presence: true
#     validates :phonenum, presence: true
#     validates :householdtype, presence: true
#     validates :headgender, presence: true
#     validates :headethnicity, presence: true
#     validates :foodstamps, presence: true
#     validates :incomesource, presence: true
#     validates :qualifiercode, presence: true
#     validates :netincome, presence: true
#     validates :netincome, presence: true

#     # associations
#     has_many :members
#     accepts_nested_attributes_for :members
#   end


# Staging-1
 #   validates :headname, presence: true
  #  validates :headdob, presence: true
   # validates :numadults, presence: true
    #validates :numchild, presence: true
    #validates :streetaddr, presence: true
    #validates :city, presence: true
    #validates :state, presence: true
    #validates :county, presence: true
    #validates :zipcode, presence: true
    #validates :phonenum, presence: true
    #validates :householdtype, presence: true
    #validates :headgender, presence: true
    #validates :headethnicity, presence: true
    #validates :foodstamps, presence: true
    #validates :incomesource, presence: true
    #validates :qualifiercode, presence: true
    #validates :netincome, presence: true

    # associations
    #has_many :members

    #Team 22: households belongs to user & is optional
   # belongs_to :user, optional: true
    #Team 22: presence of user validated based on value of required user
    #validates_presence_of :user, if: :user_required?

   # private
  
    #Team 22: only users that are associated with household & not an admin require a user
    def user_required?
      !user.nil? && !user.admin?
    end
  
