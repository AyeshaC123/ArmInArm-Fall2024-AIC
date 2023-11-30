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

ActiveRecord::Schema.define(version: 2023_11_30_013917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_configs", force: :cascade do |t|
    t.string "name"
    t.string "logo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "address"
    t.string "language"
    t.string "religion"
    t.string "allergies"
    t.string "restrictions"
  end

  create_table "households", force: :cascade do |t|
    t.string "headname"
    t.date "headdob"
    t.string "headgender"
    t.string "headethnicity"
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
    t.bigint "user_id"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin"
    t.boolean "registered"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "members", "households"
end
