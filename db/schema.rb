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

ActiveRecord::Schema.define(version: 20140716165748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: true do |t|
    t.integer  "location_id"
    t.string   "name"
    t.integer  "badge_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["location_id"], name: "index_employees_on_location_id", using: :btree

  create_table "ingredients", force: true do |t|
    t.integer  "menu_item_id"
    t.string   "name"
    t.integer  "calories"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["menu_item_id"], name: "index_ingredients_on_menu_item_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "street_address"
    t.string   "street_address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", force: true do |t|
    t.string   "name",                        null: false
    t.float    "price",       default: 0.0
    t.text     "description"
    t.boolean  "vegetarian",  default: false
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["vegetarian"], name: "index_menu_items_on_vegetarian", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
