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

ActiveRecord::Schema.define(version: 20140801084853) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "awards", force: true do |t|
    t.date     "year"
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifications", force: true do |t|
    t.integer  "user_id"
    t.date     "year"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkpoint_answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "checkpoint_id"
    t.string   "content"
    t.integer  "point"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkpoint_periods", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "checkpoints", force: true do |t|
    t.integer  "user_id"
    t.integer  "approve_id"
    t.integer  "reviewer_id"
    t.string   "ranking"
    t.integer  "checkpoint_period_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "report_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "costs", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "mon_of_week"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "educations", force: true do |t|
    t.integer  "user_id"
    t.date     "from_date"
    t.date     "to_date"
    t.string   "degree"
    t.string   "school_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "fixed"
    t.text     "page_link"
  end

  create_table "foreign_languages", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hobbies", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_hometowns", force: true do |t|
    t.string   "name"
    t.integer  "country_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notify_users", force: true do |t|
    t.integer  "user_id"
    t.boolean  "checked",     default: false
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payslips", force: true do |t|
    t.integer  "user_id"
    t.string   "payslip"
    t.string   "paymonth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "deleted_at"
  end

  create_table "period_questions", force: true do |t|
    t.integer  "checkpoint_period_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pickup_list_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "pickup_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pickup_lists", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "create_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_user_roles", force: true do |t|
    t.integer  "project_user_id"
    t.integer  "project_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_users", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "state"
    t.date     "join_date"
    t.date     "due_date"
    t.date     "resigned_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "url"
    t.boolean  "is_publish"
    t.string   "state"
    t.date     "start_date"
    t.date     "due_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "create_user_id"
  end

  create_table "question_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.boolean  "evaluation"
    t.string   "checkpoint_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_type_id"
  end

  create_table "report_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "report_category_id"
    t.integer  "user_id"
    t.text     "title"
    t.text     "description"
    t.date     "report_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_vacations", force: true do |t|
    t.integer  "vacation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "role_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sent_users", force: true do |t|
    t.string   "uid"
    t.boolean  "sent"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.float    "years",      limit: 24
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stickies", force: true do |t|
    t.integer  "stickyable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stickyable_type"
  end

  create_table "support_users", force: true do |t|
    t.integer  "report_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_answer_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "checkpoint_answer_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_foreign_languages", force: true do |t|
    t.integer  "user_id"
    t.integer  "foreign_language_id"
    t.string   "degree"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.integer  "team_id"
    t.string   "cardID"
    t.string   "position"
    t.string   "avatar"
    t.string   "uid"
    t.string   "residential_address"
    t.string   "tel"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "foreign_language"
    t.string   "contract_type"
    t.string   "university"
    t.string   "identity_id"
    t.string   "license_plate"
    t.string   "ticket"
    t.date     "birthday"
    t.date     "join_date"
    t.date     "resigned_date"
    t.string   "state"
    t.time     "deleted_at"
    t.string   "branch"
    t.string   "employee_type"
    t.string   "mother_tongue"
    t.string   "degree"
    t.integer  "m_hometown_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["m_hometown_id"], name: "index_users_on_m_hometown_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "vacation_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vacations", force: true do |t|
    t.integer  "user_id"
    t.integer  "vacation_type_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "total_day",         limit: 24
    t.date     "compensating_date"
    t.float    "hour",              limit: 24
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
