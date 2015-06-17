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

ActiveRecord::Schema.define(version: 20110130081623) do

  create_table "images", force: :cascade do |t|
    t.date     "date"
    t.string   "caption"
    t.text     "description"
    t.string   "full_path_url"
    t.string   "thumbnail_url"
    t.string   "flickr_url"
    t.string   "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",             null: false
    t.string   "crypted_password",  null: false
    t.string   "password_salt",     null: false
    t.string   "persistence_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
