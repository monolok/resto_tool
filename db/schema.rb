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

ActiveRecord::Schema.define(version: 20150419094221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "pom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "position",   default: "No position"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "pom"
    t.integer  "user_id"
  end

  create_table "reviewers", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
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
    t.integer  "vl"
    t.integer  "l"
    t.integer  "m"
    t.integer  "h"
    t.integer  "vh"
  end

  add_index "reviewers", ["email"], name: "index_reviewers_on_email", unique: true, using: :btree
  add_index "reviewers", ["reset_password_token"], name: "index_reviewers_on_reset_password_token", unique: true, using: :btree

  create_table "scores", force: true do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "qu1"
    t.integer  "qu2"
    t.integer  "qu3"
    t.integer  "qu4"
    t.integer  "qu5"
    t.integer  "qu6"
    t.integer  "qu7"
    t.integer  "qu8"
    t.integer  "qu9"
    t.integer  "qu10"
    t.integer  "qu11"
    t.integer  "qu12"
    t.integer  "qu13"
    t.integer  "qu14"
    t.integer  "qu15"
    t.integer  "qu16"
    t.integer  "qu17"
    t.integer  "qu18"
    t.integer  "qu19"
    t.integer  "qu20"
    t.integer  "qu21"
    t.integer  "qu22"
    t.integer  "qu23"
    t.integer  "qu24"
    t.integer  "qu25"
    t.integer  "qu26"
    t.integer  "qu27"
    t.integer  "qu28"
    t.integer  "qu29"
    t.integer  "employee_id"
    t.decimal  "average",     precision: 16, scale: 2
    t.integer  "reviewer_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "plan_id"
    t.string   "stripe_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.float    "average_border",         default: 2.5
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
