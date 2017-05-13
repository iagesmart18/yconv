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

ActiveRecord::Schema.define(version: 20170513215516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "attachments", force: :cascade do |t|
    t.integer  "content_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "format"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["content_id"], name: "index_attachments_on_content_id", using: :btree
  end

  create_table "contents", force: :cascade do |t|
    t.string   "name"
    t.text     "human_name"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "status"
    t.decimal  "progress",         precision: 5, scale: 2
    t.string   "url"
    t.string   "state"
    t.string   "source_filename"
    t.text     "error_msg"
    t.integer  "source_file_size"
    t.index ["name"], name: "index_contents_on_name", using: :btree
  end

end
