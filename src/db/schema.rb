# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_04_29_100310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_panels", force: :cascade do |t|
    t.integer "appointment_length"
    t.integer "max_appointment_count"
    t.integer "service_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "booking_days", default: [], array: true
    t.time "start_time"
    t.time "end_time"
    t.string "event_title"
    t.date "start_date"
    t.date "end_date"
    t.text "location", default: ["Trenton"], array: true
    t.boolean "re_occur", default: true
    t.integer "check_in_grace_period"
    t.boolean "event_active", default: true
  end

  create_table "app_configs", force: :cascade do |t|
    t.string "name"
    t.string "logo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "date_of_appt"
    t.datetime "time_of_appt"
    t.string "location"
    t.string "last_name"
    t.date "dob"
    t.date "date_of_appts"
    t.time "time_of_appts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "client_self_check_in", default: false
    t.boolean "check_in_user", default: false
    t.string "first_name"
    t.bigint "admin_panels_id"
    t.index ["admin_panels_id"], name: "index_appointments_on_admin_panels_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "address"
    t.string "language"
    t.string "religion"
    t.string "restrictions"
    t.string "client_email"
    t.string "phone_number"
    t.boolean "consent_to_msgs"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.string "household_type"
    t.string "hoh_gender"
    t.string "hoh_race_ethnicity"
    t.integer "num_adults"
    t.integer "num_children"
    t.string "non_hoh_first_name"
    t.string "non_hoh_last_name"
    t.date "non_hoh_dob"
    t.string "non_hoh_relationship"
    t.boolean "receive_snaps"
    t.string "income_source"
    t.string "qualifier_code"
    t.integer "net_income"
    t.boolean "spouse"
    t.boolean "child"
    t.boolean "mother"
    t.boolean "father"
    t.boolean "sibling"
    t.boolean "grandchild"
    t.boolean "grandparent"
    t.boolean "niece"
    t.boolean "nephew"
    t.boolean "aunt"
    t.boolean "uncle"
    t.boolean "cousin"
    t.boolean "son_in_law"
    t.boolean "daughter_in_law"
    t.boolean "parent_in_law"
    t.boolean "friend"
    t.boolean "allergy_peanuts"
    t.boolean "allergy_treenuts"
    t.boolean "allergy_eggs"
    t.boolean "allergy_milk"
    t.boolean "allergy_shellfish"
    t.boolean "allergy_fish"
    t.boolean "allergy_wheat"
    t.boolean "allergy_soy"
    t.boolean "gluten_free"
    t.boolean "vegan"
    t.string "default_location", default: "Princeton"
  end

  create_table "counties", force: :cascade do |t|
    t.string "county_name"
    t.string "state_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "households", force: :cascade do |t|
    t.string "headname"
    t.date "headdob"
    t.string "headgender"
    t.string "headethnicity"
    t.integer "numadults"
    t.integer "numchild"
    t.string "pantrylocation"
    t.string "streetaddr"
    t.string "city"
    t.string "state"
    t.string "county"
    t.string "zipcode"
    t.string "phonenum"
    t.string "incomesource"
    t.string "qualifiercode"
    t.integer "netincome"
    t.string "householdtype"
    t.string "foodstamps"
    t.boolean "reviewed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.boolean "flag", default: false
    t.index ["headname"], name: "index_households_on_headname"
    t.index ["user_id"], name: "index_households_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "operating_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "operating_days"
  end

  create_table "members", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.date "dob"
    t.string "relationship"
    t.bigint "household_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["household_id"], name: "index_members_on_household_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "role_assignments", force: :cascade do |t|
    t.integer "role_id"
    t.integer "time_slot_id"
    t.integer "people_count"
    t.integer "volunteer_id"
    t.index ["volunteer_id"], name: "index_role_assignments_on_volunteer_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_slots", force: :cascade do |t|
    t.string "day_of_week"
  end

  create_table "translations", id: false, force: :cascade do |t|
    t.string "key"
    t.string "en"
    t.string "es"
    t.string "ht"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "client_id"
    t.integer "role", default: 0, null: false
    t.string "locale", limit: 2, default: "en"
    t.boolean "registered", default: false
    t.integer "admin", default: 0
    t.index ["client_id"], name: "index_users_on_client_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteer_assignments", force: :cascade do |t|
    t.integer "volunteer_id"
    t.integer "role_id"
    t.integer "time_slot_id"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "volunteer_name"
    t.string "volunteer_phone"
    t.string "day"
    t.text "interests"
  end

  add_foreign_key "appointments", "admin_panels", column: "admin_panels_id"
  add_foreign_key "households", "users"
  add_foreign_key "members", "households"
  add_foreign_key "users", "clients"
end
