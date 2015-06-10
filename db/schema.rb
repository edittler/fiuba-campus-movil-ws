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

ActiveRecord::Schema.define(version: 20150609230157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_infos", force: :cascade do |t|
    t.string   "padron"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "carreer"
  end

  add_index "academic_infos", ["user_id"], name: "index_academic_infos_on_user_id", using: :btree

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "discussion_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "wall_id"
    t.string   "date"
    t.string   "post_type",     default: "comment"
  end

  add_index "comments", ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  add_index "comments", ["wall_id"], name: "index_comments_on_wall_id", using: :btree

  create_table "date_intervals", force: :cascade do |t|
    t.datetime "init"
    t.datetime "end"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "job_id"
    t.integer  "education_id"
  end

  add_index "date_intervals", ["education_id"], name: "index_date_intervals_on_education_id", using: :btree

  create_table "discussions", force: :cascade do |t|
    t.string   "subject"
    t.integer  "forum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "discussions", ["forum_id"], name: "index_discussions_on_forum_id", using: :btree
  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

  create_table "educations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
    t.string   "diploma"
  end

  add_index "educations", ["profile_id"], name: "index_educations_on_profile_id", using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "group_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "forums", ["group_id"], name: "index_forums_on_group_id", using: :btree

  create_table "friendship_requests", force: :cascade do |t|
    t.integer  "sender_user_id",   null: false
    t.integer  "receiver_user_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "friendship_requests", ["receiver_user_id"], name: "index_friendship_requests_on_receiver_user_id", using: :btree
  add_index "friendship_requests", ["sender_user_id"], name: "index_friendship_requests_on_sender_user_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "this_user_id",  null: false
    t.integer  "other_user_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "friendships", ["other_user_id"], name: "index_friendships_on_other_user_id", using: :btree
  add_index "friendships", ["this_user_id"], name: "index_friendships_on_this_user_id", using: :btree

  create_table "group_memberships", force: :cascade do |t|
    t.string   "member_type"
    t.integer  "member_id"
    t.integer  "group_id"
    t.string   "membership_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id", using: :btree
  add_index "group_memberships", ["member_id", "member_type"], name: "index_group_memberships_on_member_id_and_member_type", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "institutes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "education_id"
  end

  add_index "institutes", ["education_id"], name: "index_institutes_on_education_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "company"
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
  end

  add_index "jobs", ["profile_id"], name: "index_jobs_on_profile_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "profile_id"
    t.string   "last_update_time"
  end

  create_table "nationalities", force: :cascade do |t|
    t.string   "nationality"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "profile_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "type"
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "biography"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "uploaded_data", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "group_id"
    t.string   "uploader_name"
    t.string   "file_type"
    t.integer  "user_id"
  end

  add_index "uploaded_data", ["group_id"], name: "index_uploaded_data_on_group_id", using: :btree
  add_index "uploaded_data", ["user_id"], name: "index_uploaded_data_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.boolean  "approved",               default: false, null: false
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "walls", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "walls", ["user_id"], name: "index_walls_on_user_id", using: :btree

  add_foreign_key "academic_infos", "users"
  add_foreign_key "comments", "discussions"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "walls"
  add_foreign_key "date_intervals", "educations"
  add_foreign_key "discussions", "forums"
  add_foreign_key "discussions", "users"
  add_foreign_key "educations", "profiles"
  add_foreign_key "forums", "groups"
  add_foreign_key "institutes", "educations"
  add_foreign_key "jobs", "profiles"
  add_foreign_key "uploaded_data", "groups"
  add_foreign_key "uploaded_data", "users"
  add_foreign_key "walls", "users"
end
