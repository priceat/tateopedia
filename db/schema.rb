
ActiveRecord::Schema.define(version: 20141125002821) do

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "standard"
    t.string   "stripe_customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wikis", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "private"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wikis", ["user_id"], name: "index_wikis_on_user_id"

end
