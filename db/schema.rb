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

ActiveRecord::Schema.define(version: 20160625130103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "clientId"
    t.string   "contactPerson"
    t.string   "companyName"
    t.string   "companyAddress"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "slug"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "items", force: :cascade do |t|
    t.text     "description"
    t.integer  "quantity",      default: 1
    t.float    "unitPrice"
    t.float    "totalPrice"
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "items", ["itemable_id", "itemable_type"], name: "index_items_on_itemable_id_and_itemable_type", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "phoneNumber"
    t.string   "accountType"
    t.string   "businessName"
    t.text     "businessAddress"
    t.string   "businessRegNumber"
    t.string   "csPhoneNumber"
    t.string   "businessTaxRegNumber"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "quotations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipientId"
    t.string   "quoteId"
    t.datetime "validUntil"
    t.integer  "status",      default: 0
    t.float    "subTotal"
    t.float    "taxRate",     default: 0.0
    t.float    "tax"
    t.float    "total"
    t.text     "note"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "slug"
  end

  add_index "quotations", ["user_id"], name: "index_quotations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "username",               default: "",    null: false
    t.boolean  "admin",                  default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "clients", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "quotations", "users"
end
