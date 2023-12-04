json.extract! member, :id, :firstname, :lastname, :dob, :relationship, :household_id, :created_at, :updated_at
json.url member_url(member, format: :json)
