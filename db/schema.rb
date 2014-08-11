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

ActiveRecord::Schema.define(version: 20140811052002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatroom_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chatroom_users", ["chatroom_id"], name: "index_chatroom_users_on_chatroom_id", using: :btree
  add_index "chatroom_users", ["user_id"], name: "index_chatroom_users_on_user_id", using: :btree

  create_table "chatrooms", force: true do |t|
    t.integer  "language_id"
    t.boolean  "matched",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "concluded",   default: false
  end

  add_index "chatrooms", ["language_id"], name: "index_chatrooms_on_language_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token_key"
    t.string   "token_expiration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tokens", ["uid"], name: "index_tokens_on_uid", using: :btree
  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "inactive",   default: false
    t.boolean  "banned",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
