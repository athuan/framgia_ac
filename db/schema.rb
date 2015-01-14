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

ActiveRecord::Schema.define(version: 20150120080907) do

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

  create_table "excels", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salary_reports", force: true do |t|
    t.string   "month"
    t.string   "year"
    t.boolean  "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sent_users", force: true do |t|
    t.integer  "salary_report_id"
    t.string   "uid"
    t.boolean  "sent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", force: true do |t|
    t.string   "name"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_type"
  end

  create_table "users", force: true do |t|
    t.string   "display_name"
    t.string   "email"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "role"
    t.string   "remember_token"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
