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

ActiveRecord::Schema.define(version: 20150411111005) do

  create_table "earthquakes", force: :cascade do |t|
    t.datetime "time_stamp"
    t.time     "time_of_day"
    t.decimal  "latitude",         precision: 7,  scale: 4
    t.decimal  "longitude",        precision: 7,  scale: 4
    t.decimal  "depth",            precision: 5,  scale: 2
    t.decimal  "mag",              precision: 2,  scale: 1
    t.string   "mag_type"
    t.integer  "nst"
    t.decimal  "gap",              precision: 4,  scale: 1
    t.decimal  "dmin",             precision: 10, scale: 7
    t.decimal  "rms",              precision: 8,  scale: 6
    t.string   "net"
    t.string   "quake_identifier"
    t.datetime "updated"
    t.string   "place"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

end
