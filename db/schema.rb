# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_11_144646) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "alumni", force: :cascade do |t|
    t.integer "uin"
    t.integer "cohort_year"
    t.string "team_affiliation"
    t.string "profession_title"
    t.boolean "availability"
    t.string "email"
    t.string "phone_number"
    t.string "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alumnus_experiences", force: :cascade do |t|
    t.bigint "alumnus_id", null: false
    t.bigint "experience_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_received"
    t.text "custom_description"
    t.index ["alumnus_id"], name: "index_alumnus_experiences_on_alumnus_id"
    t.index ["experience_id"], name: "index_alumnus_experiences_on_experience_id"
  end

  create_table "change_logs", force: :cascade do |t|
    t.string "user"
    t.string "action"
    t.string "record_type"
    t.integer "record_id"
    t.text "change_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "experiences", force: :cascade do |t|
    t.string "title"
    t.string "experience_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gmails", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.index ["email"], name: "index_gmails_on_email", unique: true
  end

  create_table "users", primary_key: "uin", id: :serial, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_initial", default: ""
    t.string "status", default: ""
    t.boolean "isAdmin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alumnus_experiences", "alumni"
  add_foreign_key "alumnus_experiences", "experiences"
end
