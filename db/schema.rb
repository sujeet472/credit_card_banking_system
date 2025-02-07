# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_07_053638) do
  create_table "account_transactions", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "user_card_id", limit: 20, null: false
    t.datetime "transaction_date", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "merchant_id", limit: 20, null: false
    t.string "location", limit: 100
    t.string "transaction_type", limit: 50, default: "purchase", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_account_transactions_on_discarded_at"
  end

  create_table "branches", id: :string, force: :cascade do |t|
    t.string "branch_name", limit: 50, null: false
    t.text "branch_address", null: false
    t.string "branch_manager", limit: 50, null: false
    t.string "branch_phone", limit: 15, null: false
    t.string "branch_email", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["branch_email"], name: "index_branches_on_branch_email", unique: true
    t.index ["branch_phone"], name: "index_branches_on_branch_phone", unique: true
    t.index ["discarded_at"], name: "index_branches_on_discarded_at"
  end

  create_table "credit_cards", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "type_of_card", null: false
    t.decimal "credit_limit", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_credit_cards_on_discarded_at"
  end

  create_table "customers", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.date "date_of_birth", null: false
    t.string "email", limit: 100, null: false
    t.integer "phone_number", limit: 15, null: false
    t.text "address", null: false
    t.string "branch_id", limit: 20
    t.string "profile_image", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_type", default: "saving", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_customers_on_discarded_at"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["phone_number"], name: "index_customers_on_phone_number", unique: true
  end

  create_table "rewards", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "account_transaction_id", limit: 20, null: false
    t.string "user_card_id", limit: 20, null: false
    t.integer "points_earned", null: false
    t.integer "points_redeemed", null: false
    t.datetime "last_updated", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["account_transaction_id"], name: "index_rewards_on_account_transaction_id"
    t.index ["discarded_at"], name: "index_rewards_on_discarded_at"
    t.index ["user_card_id"], name: "index_rewards_on_user_card_id"
  end

  create_table "user_cards", id: { type: :string, limit: 20 }, force: :cascade do |t|
    t.string "credit_card_id", limit: 20, null: false
    t.string "customer_id", limit: 20, null: false
    t.date "issue_date", null: false
    t.date "expiry_date", null: false
    t.boolean "is_active", default: true
    t.decimal "available_limit", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hashed_cvv"
    t.datetime "discarded_at"
    t.index ["credit_card_id"], name: "index_user_cards_on_credit_card_id"
    t.index ["customer_id"], name: "index_user_cards_on_customer_id"
    t.index ["discarded_at"], name: "index_user_cards_on_discarded_at"
  end

  add_foreign_key "account_transactions", "customers", column: "merchant_id"
  add_foreign_key "account_transactions", "user_cards"
  add_foreign_key "customers", "branches"
  add_foreign_key "rewards", "account_transactions"
  add_foreign_key "rewards", "user_cards"
  add_foreign_key "user_cards", "credit_cards"
  add_foreign_key "user_cards", "customers"
end
