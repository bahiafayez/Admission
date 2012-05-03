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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120503114654) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "addresses", :force => true do |t|
    t.text     "address"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "fax"
    t.string   "address_type"
    t.integer  "applicant_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admission_informations", :force => true do |t|
    t.float    "toefl_test_results"
    t.date     "toefl_test_date"
    t.boolean  "proficiency_test"
    t.integer  "applicant_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "school_id"
    t.integer  "semester_id"
    t.integer  "major_id"
  end

  create_table "applicants", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "gender"
    t.string   "military_status",         :default => "Does not apply"
    t.string   "national_id"
    t.date     "national_id_expiry_date"
    t.string   "passport_number"
    t.string   "country_of_issuance"
    t.date     "passport_expiry_date"
    t.text     "academic_honours"
    t.text     "extra_activities"
    t.string   "transportation"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.integer  "user_id"
    t.string   "status",                  :default => "Just Created"
    t.boolean  "checkSecondary"
    t.boolean  "checkCollege"
    t.boolean  "checkWork"
    t.text     "notes"
    t.boolean  "closed",                  :default => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "school_certificates_file_name"
    t.string   "school_certificates_content_type"
    t.integer  "school_certificates_file_size"
    t.datetime "school_certificates_updated_at"
    t.string   "personal_experience_file_name"
    t.string   "personal_experience_content_type"
    t.integer  "personal_experience_file_size"
    t.datetime "personal_experience_updated_at"
    t.string   "additional_information_file_name"
    t.string   "additional_information_content_type"
    t.integer  "additional_information_file_size"
    t.datetime "additional_information_updated_at"
    t.integer  "applicant_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.string   "faculty"
    t.string   "major"
    t.string   "city"
    t.string   "country"
    t.date     "attended_from"
    t.date     "attended_to"
    t.string   "language"
    t.string   "gpa",           :default => ""
    t.integer  "applicant_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "guardians", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "occupation"
    t.string   "company_name"
    t.string   "business_telephone"
    t.string   "email"
    t.string   "fax"
    t.text     "business_address"
    t.string   "relation"
    t.boolean  "financial"
    t.integer  "applicant_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "healths", :force => true do |t|
    t.string   "illness"
    t.text     "description"
    t.integer  "applicant_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "majors", :force => true do |t|
    t.string   "name"
    t.boolean  "status"
    t.integer  "school_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "other_choices", :force => true do |t|
    t.boolean  "quality"
    t.boolean  "reputation"
    t.boolean  "facilities"
    t.boolean  "location"
    t.boolean  "fields_of_study"
    t.string   "specify_fields_of_study"
    t.boolean  "other"
    t.string   "specify_other"
    t.integer  "uni_related_info_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "secondary_schools", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "language"
    t.date     "attended_from"
    t.date     "attended_to"
    t.string   "certificate_type"
    t.date     "graduation_date"
    t.string   "division"
    t.string   "school_type"
    t.integer  "applicant_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "uni_choices", :force => true do |t|
    t.boolean  "internet"
    t.boolean  "email"
    t.boolean  "radio"
    t.boolean  "school_visits"
    t.boolean  "nile_university_faculty_and_staff"
    t.boolean  "nile_university_student_and_alumni"
    t.boolean  "print_advertisements"
    t.string   "specify_print_advertisements"
    t.boolean  "nu_seminar_workshop_and_conference"
    t.string   "specify_nu_seminar"
    t.boolean  "other"
    t.string   "specify_other"
    t.integer  "uni_related_info_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "uni_related_infos", :force => true do |t|
    t.string   "hear_of_uni"
    t.text     "factors"
    t.text     "majors"
    t.text     "other_universities"
    t.text     "factors_other_universities"
    t.integer  "applicant_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_salt"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "works", :force => true do |t|
    t.string   "employer"
    t.date     "worked_from"
    t.date     "worked_to"
    t.text     "tasks",        :limit => 255
    t.integer  "applicant_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

end
