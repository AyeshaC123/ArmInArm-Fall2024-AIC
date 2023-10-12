class Client < ApplicationRecord
    # ActiveRecord automatically creates attribute accessors for all the database columns
  
    # Validations
    validates :first_name, :last_name, :dob, :age, presence: true
  
    # Serialized attributes for storing arrays in the database
    serialize :allergies, Array
    serialize :restrictions, Array
  
    # Custom methods (similar to your original class)
  
    def add_allergy(allergy)
      self.allergies << allergy
    end
  
    def add_restriction(restriction)
      self.restrictions << restriction
    end
  end