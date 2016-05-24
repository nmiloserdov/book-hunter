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

ActiveRecord::Schema.define(version: 5) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "author"
    t.string "title"
  end

  create_table "books_categories", force: :cascade do |t|
    t.integer "book_id"
    t.integer "category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.boolean "read"
  end

  create_table "users", force: :cascade do |t|
    t.integer "telegram_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "nickname"
  end

end
