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

ActiveRecord::Schema.define(version: 2020_01_10_063523) do

  create_table "locodes", force: :cascade do |t|
    t.string "code"
    t.string "city"
    t.string "name"
    t.string "name_diacritics"
    t.string "function"
    t.string "iata"
    t.string "status"
    t.string "date"
    t.string "remarks"
    t.string "coordinates"
    t.float "latitude"
    t.float "longitude"
    t.integer "sub_division_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_division_id"], name: "index_locodes_on_sub_division_id"
  end

  create_table "sub_divisions", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "region"
    t.string "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
