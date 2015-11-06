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

ActiveRecord::Schema.define(version: 20151027030612) do

  create_table "activities", force: :cascade do |t|
    t.string   "behavior",   limit: 255
    t.string   "object",     limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.boolean  "is_correct",             default: false
    t.integer  "word_id",    limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "answers", ["word_id"], name: "index_answers_on_word_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "category_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "lessons", ["category_id"], name: "index_lessons_on_category_id", using: :btree
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true, using: :btree
  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "lesson_id",  limit: 4
    t.integer  "answer_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "results", ["answer_id"], name: "index_results_on_answer_id", using: :btree
  add_index "results", ["lesson_id"], name: "index_results_on_lesson_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.boolean  "admin",                         default: false
    t.string   "password_digest",   limit: 255
    t.string   "remember_digest",   limit: 255
    t.string   "activation_digest", limit: 255
    t.boolean  "activated",                     default: false
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
    t.datetime "reset_send_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "words", force: :cascade do |t|
    t.string   "content",     limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "words", ["category_id"], name: "index_words_on_category_id", using: :btree

  add_foreign_key "activities", "users"
  add_foreign_key "answers", "words"
  add_foreign_key "lessons", "categories"
  add_foreign_key "lessons", "users"
  add_foreign_key "results", "answers"
  add_foreign_key "results", "lessons"
  add_foreign_key "words", "categories"
end
