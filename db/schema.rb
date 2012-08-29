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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120827194734) do

  create_table "levels", :force => true do |t|
    t.integer  "level"
    t.string   "level_name"
    t.string   "image_url"
    t.string   "badge_type",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "facebook_id", :null => false
  end

  create_table "pecoris", :force => true do |t|
    t.integer  "pecorer_id"
    t.integer  "pecoree_id"
    t.string   "pecori_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "facebook_id",         :null => false
    t.string   "pecorin_token"
    t.string   "access_token"
    t.string   "name"
    t.string   "image_url"
    t.string   "registration_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "current_location_id"
  end

end
