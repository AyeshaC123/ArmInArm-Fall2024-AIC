# app/models/household.rb
# frozen_string_literal: true

class Household < ApplicationRecord
    # Add validations or associations as needed
    validates :headname, presence: true
    validates :headdob, presence: true
    validates :numadults, presence: true
    validates :numchild, presence: true
    validates :streetaddr, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :county, presence: true
    validates :zipcode, presence: true
    validates :phonenum, presence: true 
    validates :householdtype, presence: true
    validates :headgender, presence: true
    validates :headethnicity, presence: true
    validates :foodstamps, presence: true
    validates :incomesource, presence: true
    validates :qualifiercode, presence: true
    validates :netincome, presence: true

    # associations
    has_many :members

  end
  