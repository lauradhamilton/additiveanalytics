# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140929160030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audit_logs", force: true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "audit_logs", ["user_id"], name: "index_audit_logs_on_user_id", using: :btree

  create_table "immunization_task_statuses", force: true do |t|
    t.integer  "immunization_task_id"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "immunization_tasks", force: true do |t|
    t.integer  "patient_id"
    t.string   "immunization"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "series_number"
  end

  add_index "immunization_tasks", ["patient_id", "immunization"], name: "index_immunization_tasks_on_patient_id_and_immunization", unique: true, using: :btree

  create_table "immunizations", force: true do |t|
    t.integer "patient_id"
    t.integer "entry_code"
    t.string  "section"
    t.string  "status"
    t.string  "detail"
    t.string  "code"
    t.decimal "trans_id"
    t.date    "display_date"
    t.string  "description"
  end

  create_table "influenzas", force: true do |t|
    t.date     "view_date",   null: false
    t.string   "title",       null: false
    t.integer  "daily_views", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "influenzas", ["view_date", "title"], name: "index_influenzas_on_view_date_and_title", unique: true, using: :btree

  create_table "medicare_cost_summaries", id: false, force: true do |t|
    t.integer "id",               null: false
    t.string  "provider_name"
    t.string  "state"
    t.text    "procedure_type"
    t.integer "procedures_count"
    t.decimal "average_cost"
  end

  create_table "medicare_costs", force: true do |t|
    t.integer  "npi"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "mi"
    t.string   "credentials"
    t.string   "gender"
    t.string   "entity_code"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "country"
    t.string   "provider_type"
    t.string   "medicare_participation_indicator"
    t.string   "place_of_service"
    t.string   "hcpcs_code"
    t.string   "hcpcs_description"
    t.float    "services_provided_count"
    t.integer  "beneficiaries_count"
    t.integer  "distinct_services_per_beneficiary_count"
    t.decimal  "average_medicare_allowed_amount",         precision: 8, scale: 2
    t.decimal  "stdev_medicare_allowed_amount",           precision: 8, scale: 2
    t.decimal  "average_submitted_charge_amount",         precision: 8, scale: 2
    t.decimal  "stdev_submitted_charge_amount",           precision: 8, scale: 2
    t.decimal  "average_medicare_payment_amount",         precision: 8, scale: 2
    t.decimal  "stdev_medicare_payment_amount",           precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nationwide_cost_averages", id: false, force: true do |t|
    t.text    "procedure_type"
    t.decimal "nationwide_average"
  end

  create_table "patient_appointments", force: true do |t|
    t.integer  "appointment_id"
    t.datetime "appointment_time"
    t.integer  "patient_id"
    t.integer  "duration"
    t.string   "status"
    t.integer  "encounter_number"
    t.datetime "time_scheduled"
    t.datetime "time_confirmed"
    t.integer  "scheduling_location_id"
    t.string   "scheduled_location_abbreviation"
    t.string   "scheduled_location_description"
    t.integer  "scheduling_department_id"
    t.integer  "resource_id"
    t.integer  "appointment_type_id"
    t.string   "appointment_type_abbreviation"
    t.string   "appointment_type_description"
    t.string   "coverage_type"
    t.string   "patient_first_name"
    t.string   "patient_last_name"
    t.integer  "patient_number"
    t.string   "attending_first_name"
    t.string   "attending_last_name"
    t.string   "attending_suffix"
    t.string   "attending_abbreviation"
  end

  create_table "patients", force: true do |t|
    t.string  "age"
    t.string  "gender"
    t.string  "marital_status"
    t.string  "first_name"
    t.string  "middle_name"
    t.string  "last_name"
    t.string  "suffix"
    t.string  "occupation"
    t.string  "employer"
    t.integer "phone_number",         limit: 8
    t.integer "work_phone",           limit: 8
    t.integer "cell_phone",           limit: 8
    t.string  "address_line_1"
    t.string  "address_line_2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "email"
    t.date    "date_of_birth"
    t.integer "physician_phone",      limit: 8
    t.string  "physician_first_name"
    t.string  "physician_last_name"
    t.string  "physician_username"
    t.string  "base64image"
    t.string  "primary_insurance"
    t.string  "language"
    t.string  "race"
    t.string  "ethnicity"
    t.integer "patient_id",           limit: 8
    t.string  "ssn",                  limit: 11
    t.string  "mrn"
    t.binary  "picture_of_patient"
    t.string  "age_dec"
    t.string  "patient_location"
  end

  add_index "patients", ["patient_id"], name: "index_patients_on_patient_id", unique: true, using: :btree

  create_table "price_variances_by_state", id: false, force: true do |t|
    t.string  "state"
    t.decimal "diff_versus_nationwide_average"
  end

  create_table "price_variances_by_states", id: false, force: true do |t|
    t.integer "id",                             null: false
    t.string  "state"
    t.decimal "diff_versus_nationwide_average"
  end

  create_table "providers", force: true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "suffix_name"
    t.string   "prefix_name"
    t.string   "title_name"
    t.integer  "entry_code"
    t.string   "entry_pneumonic"
    t.string   "provider_key_ext"
    t.integer  "npi",                  limit: 8
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.integer  "phone",                limit: 8
    t.integer  "fax",                  limit: 8
    t.string   "specialty"
    t.boolean  "provider_is_inactive"
    t.date     "expiration_date"
    t.integer  "dea_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["code"], name: "index_states_on_code", unique: true, using: :btree
  add_index "states", ["name"], name: "index_states_on_name", unique: true, using: :btree

  create_table "unity_servers", force: true do |t|
    t.string   "server_time_zone"
    t.datetime "server_time"
    t.string   "server_date_time_offset"
    t.string   "system"
    t.string   "product_version"
    t.date     "uai_born_on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",               default: false, null: false
    t.string   "authentication_token"
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
