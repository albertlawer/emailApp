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

ActiveRecord::Schema.define(version: 20200630155017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_infos", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_one"
    t.string   "phone_two"
    t.integer  "payment_type"
    t.date     "expiry_date"
    t.boolean  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "status"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails_mail_groups", force: :cascade do |t|
    t.integer  "email_id"
    t.integer  "mail_group_id"
    t.boolean  "status"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "mail_attachments", force: :cascade do |t|
    t.string   "request_code"
    t.string   "attachment_name"
    t.string   "attachment_path"
    t.boolean  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "mail_group_mappings", force: :cascade do |t|
    t.integer  "gorup_id"
    t.integer  "email_id"
    t.boolean  "status"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mail_groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "status"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mail_masters", force: :cascade do |t|
    t.string   "request_code"
    t.integer  "email_type"
    t.string   "subject"
    t.integer  "body_template_id"
    t.boolean  "schedule_status"
    t.datetime "schedule_time"
    t.integer  "email_group"
    t.integer  "sender_email_id"
    t.integer  "company_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "payment_types", force: :cascade do |t|
    t.string   "name"
    t.string   "body"
    t.integer  "users"
    t.integer  "email_count"
    t.integer  "email_book"
    t.integer  "email_templates"
    t.integer  "sender_email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "subject_class"
    t.string   "action"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.integer  "permission_id"
    t.integer  "role_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sender_emails", force: :cascade do |t|
    t.string   "name"
    t.string   "email_username"
    t.string   "email_password"
    t.string   "email_address"
    t.string   "email_port"
    t.string   "authentication"
    t.integer  "company_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "templates", force: :cascade do |t|
    t.string   "name"
    t.string   "body"
    t.boolean  "status"
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "request_master_id"
    t.integer  "email_id"
    t.string   "subject"
    t.string   "from_mail"
    t.text     "body_message"
    t.boolean  "status"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "first_name",             default: "", null: false
    t.string   "contact_number",         default: "", null: false
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
    t.integer  "role_id"
    t.integer  "client_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
