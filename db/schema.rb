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

ActiveRecord::Schema.define(version: 20171015191155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "type"
    t.string   "country"
    t.string   "addressing"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  end

  create_table "authentication_providers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_name_on_authentication_providers", using: :btree
  end

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "author_id"
  end

  create_table "book_attachments", force: :cascade do |t|
    t.integer  "book_id"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author_name"
    t.integer  "pick_times",          default: 0
    t.text     "description"
    t.integer  "price"
    t.boolean  "bestseller",          default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
    t.integer  "quantity"
    t.boolean  "active"
    t.integer  "category_id"
    t.integer  "order_item_id"
    t.integer  "author_id"
    t.integer  "year_of_publication"
    t.string   "demensions"
    t.string   "materials"
    t.string   "size"
    t.float    "weight",              default: 0.0
    t.string   "aasm_state"
    t.json     "photos"
    t.index ["user_id"], name: "index_books_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.integer "book_id"
    t.integer "user_id"
    t.index ["book_id"], name: "index_categories_on_book_id", using: :btree
    t.index ["user_id"], name: "index_categories_on_user_id", using: :btree
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "cvv"
    t.integer  "year"
    t.integer  "month"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "order_id"
    t.string   "expiration_date"
    t.index ["order_id"], name: "index_credit_cards_on_order_id", using: :btree
    t.index ["user_id"], name: "index_credit_cards_on_user_id", using: :btree
  end

  create_table "deliveries", force: :cascade do |t|
    t.string  "name"
    t.decimal "price"
    t.string  "days"
  end

  create_table "dimensions", force: :cascade do |t|
    t.string   "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "order_id"
    t.decimal  "unit_price"
    t.integer  "quantity"
    t.decimal  "total_price"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "coupon"
    t.integer  "dimension_id"
    t.integer  "price_id"
    t.float    "unit_weight",  default: 0.0
    t.float    "total_weight", default: 0.0
    t.index ["book_id"], name: "index_order_items_on_book_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal"
    t.decimal  "tax"
    t.decimal  "shipping"
    t.decimal  "total"
    t.integer  "order_status_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "coupon"
    t.integer  "user_id"
    t.string   "aasm_state"
    t.integer  "delivery_id",          default: 1
    t.string   "number"
    t.integer  "credit_card_id"
    t.string   "allow"
    t.float    "nova_poshta_delivery"
    t.float    "total_weight",         default: 0.0
    t.index ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
    t.index ["delivery_id"], name: "index_orders_on_delivery_id", using: :btree
    t.index ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
  end

  create_table "prices", force: :cascade do |t|
    t.float    "price"
    t.string   "size"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "text_of_review"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "aasm_state"
    t.integer  "rate"
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "user_authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "authentication_provider_id"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expires_at"
    t.text     "params"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id", using: :btree
    t.index ["user_id"], name: "index_user_authentications_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.integer  "zipcode"
    t.string   "phone"
    t.string   "country"
    t.boolean  "admin"
    t.boolean  "manager"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "credit_cards", "orders"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "order_items", "books"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "credit_cards"
  add_foreign_key "orders", "deliveries"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "reviews", "users"
end
