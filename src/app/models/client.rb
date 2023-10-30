class Client < ApplicationRecord
    # ActiveRecord automatically creates attribute accessors for all the database columns
  
    # Validations
    validates :first_name, :last_name, :dob, presence: true
  
    # Custom methods (similar to your original class)
  
    # def add_allergy(allergy)
    #   self.allergies << allergy
    # end
  
    # def add_restriction(restriction)
    #   self.restrictions << restriction
    # end
  end
