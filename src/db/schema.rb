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
end
