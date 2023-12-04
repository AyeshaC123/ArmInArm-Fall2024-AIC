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

ActiveRecord::Schema.define(version: 2023_11_29_123456) do

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
  end

  create_table "app_configs", force: :cascade do |t|
    t.string "name"
    t.string "logo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "role_assignments", id: :serial, force: :cascade do |t|
    t.integer "role_id"
    t.integer "time_slot_id"
    t.integer "people_count", default: 0
    t.integer "volunteer_id"
    t.index ["volunteer_id"], name: "index_role_assignments_on_volunteer_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "role_name", limit: 255
  end

  create_table "time_slots", id: :serial, force: :cascade do |t|
    t.string "day_of_week", limit: 255

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
  end

  create_table "households", force: :cascade do |t|
    t.string "headname"
    t.date "headdob"
    t.string "headgender"
    t.string "headethicity"
    t.integer "numadults"
    t.integer "numchild"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.bigint "client_id"
    t.integer "role", default: 0, null: false
    t.string "locale", limit: 2, default: "en"
    t.index ["client_id"], name: "index_users_on_client_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteer_assignments", id: :serial, force: :cascade do |t|
    t.integer "volunteer_id"
    t.integer "role_id"
    t.integer "time_slot_id"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "volunteer_name"
    t.string "volunteer_phone"
    t.text "interests"
    t.string "day"
  end

  add_foreign_key "role_assignments", "roles", name: "role_assignments_role_id_fkey"
  add_foreign_key "role_assignments", "time_slots", name: "role_assignments_time_slot_id_fkey"
  add_foreign_key "volunteer_assignments", "roles", name: "volunteer_assignments_role_id_fkey"
  add_foreign_key "volunteer_assignments", "time_slots", name: "volunteer_assignments_time_slot_id_fkey"
  add_foreign_key "volunteer_assignments", "volunteers", name: "volunteer_assignments_volunteer_id_fkey"
  add_foreign_key "users", "clients"
end
