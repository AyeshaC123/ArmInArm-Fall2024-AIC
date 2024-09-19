class Client < ApplicationRecord

  has_many :appointments
  # has_one :household, through: :user

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

  # Helpful constant containing list of common allergens and their names.
  COMMON_ALLERGENS = [
    [:allergy_peanuts,   "Peanuts"],
    [:allergy_treenuts,  "Tree nuts"],
    [:allergy_eggs,      "Eggs"],
    [:allergy_milk,      "Milk"],
    [:allergy_shellfish, "Shellfish"],
    [:allergy_fish,      "Fish"],
    [:allergy_wheat,     "Wheat"],
    [:allergy_soy,       "Soy"],
  ]

  has_many :users, dependent: :destroy


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

  # Custom method to create a readable string list of the client's common allergens.
  def allergies_string
    strings = []
    COMMON_ALLERGENS.each do |sym, name|
      # Send method calls a method by name, e.g. self.send :foo is the same as self.foo
      if send sym
        # Team 14: Added translation here. Having to translate here makes it difficult to use the get_translation method
        # defined in app/helpers/application_helper.rb. Using .yml files for now.
        
        # strings.push get_translation("new_client_#{sym}")
        # translation = Translation.where("key = ?", "new_client_#{sym}")[0][current_user&.locale]
        strings.push (I18n.t "new_client.#{sym}")
      end
    end
    # Join to string.
    strings.join ', '
  end
end
