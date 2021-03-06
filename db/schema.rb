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

ActiveRecord::Schema.define(version: 20160316015826) do

  create_table "api_tokens", force: :cascade do |t|
    t.string "token", limit: 255, null: false
  end

  create_table "pairing_sessions", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.datetime "end_time",   null: false
  end

  create_table "pairing_sessions_users", force: :cascade do |t|
    t.integer "pairing_session_id", limit: 4, null: false
    t.integer "user_id",            limit: 4, null: false
  end

  add_index "pairing_sessions_users", ["pairing_session_id"], name: "fk_rails_d4d4e72ec2", using: :btree
  add_index "pairing_sessions_users", ["user_id"], name: "fk_rails_2223028d7a", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string "name",  limit: 255, null: false
    t.string "value", limit: 255, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name",        limit: 255, null: false
    t.string "username",    limit: 255, null: false
    t.string "email",       limit: 255, null: false
    t.string "external_id", limit: 255
  end

  add_foreign_key "pairing_sessions_users", "pairing_sessions"
  add_foreign_key "pairing_sessions_users", "users"
end
