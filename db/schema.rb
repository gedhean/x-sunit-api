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

ActiveRecord::Schema.define(version: 2018_10_21_113556) do

  create_table "reports", primary_key: ["reporter_id", "abducted_id"], force: :cascade do |t|
    t.integer "reporter_id"
    t.text "message"
    t.integer "abducted_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survivors", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.float "latitude"
    t.float "longitude"
    t.boolean "abducted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
