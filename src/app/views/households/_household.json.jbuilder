json.extract! household, :id, :headname, :headdob, :headgender, :headethicity, :numadults, :numchild, :streetaddr, :city, :state, :county, :zipcode, :phonenum, :incomesource, :qualifiercode, :netincome, :householdtype, :foodstamps, :user_id, :created_at, :updated_at
json.url household_url(household, format: :json)
