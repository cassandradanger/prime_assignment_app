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

ActiveRecord::Schema.define(version: 20150127234918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admission_applications", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "legal_status"
    t.string   "education"
    t.string   "employment_status"
    t.string   "linkedin_account"
    t.string   "twitter_account"
    t.string   "github_account"
    t.string   "website_link"
    t.string   "resume_link"
    t.string   "referral_source"
    t.text     "question_reason_for_applying"
    t.text     "question_why_prime"
    t.text     "question_intensity"
    t.text     "question_technology_background"
    t.text     "question_self_differentiation"
    t.text     "question_three_month_prediction"
    t.text     "question_three_year_aspiration"
    t.text     "question_actions_toward_goals"
    t.string   "application_status"
    t.string   "application_step"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "completed_at"
    t.string   "address"
    t.string   "phone"
    t.integer  "income"
    t.string   "goal"
    t.string   "payment_option"
    t.integer  "resume_score"
    t.text     "resume_notes"
  end

  create_table "admission_applications_cohorts", force: true do |t|
    t.integer "admission_application_id"
    t.integer "cohort_id"
  end

  create_table "cohorts", force: true do |t|
    t.date     "prework_start"
    t.date     "classroom_start"
    t.date     "graduation"
    t.date     "applications_open"
    t.date     "applications_close"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "target_size",        default: 20
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.string   "sub_type"
    t.integer  "admin_id"
    t.integer  "is_commentable_id"
    t.string   "is_commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",            default: false
  end

  add_index "comments", ["admin_id"], name: "index_comments_on_admin_id", using: :btree
  add_index "comments", ["is_commentable_id", "is_commentable_type"], name: "index_comments_on_is_commentable_id_and_is_commentable_type", using: :btree

  create_table "logic_question_answers", force: true do |t|
    t.integer  "logic_question_id"
    t.integer  "admission_application_id"
    t.string   "answer"
    t.text     "explanation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logic_questions", force: true do |t|
    t.text     "question"
    t.string   "solution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question_image_file_name"
    t.string   "question_image_content_type"
    t.integer  "question_image_file_size"
    t.datetime "question_image_updated_at"
    t.boolean  "published"
    t.integer  "position"
  end

  create_table "profile_question_answers", force: true do |t|
    t.text     "answer"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admission_application_id"
    t.integer  "profile_question_id"
  end

  create_table "profile_questions", force: true do |t|
    t.text     "question"
    t.boolean  "published"
    t.text     "scoring_guideline_1"
    t.text     "scoring_guideline_2"
    t.text     "scoring_guideline_3"
    t.text     "scoring_guideline_4"
    t.text     "scoring_guideline_5"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
