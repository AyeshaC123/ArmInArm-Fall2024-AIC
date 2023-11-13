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

  # Custom method to derive the age of a client based on their date of birth.
  def age
    # What day is it today?
    today = Date.today
    # The client is at most as old as the difference between the years.
    result = today.year - dob.year
    # If their birthday hasn't yet passed this year, subtract one from the result.
    if today.month < dob.month or (today.month == dob.month and today.day < dob.day)
      result -= 1
    end
    # Return final result.
    result
  end
end
