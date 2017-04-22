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

ActiveRecord::Schema.define(version: 20170422011254) do

  create_table "binders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key",         null: false
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["key"], name: "index_binders_on_key", unique: true, using: :btree
  end

  create_table "histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "binder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["binder_id"], name: "index_histories_on_binder_id", using: :btree
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "binder_key"
    t.integer  "history_id"
    t.integer  "newer_report_id"
    t.integer  "older_report_id"
    t.string   "title",                                     null: false
    t.text     "body",            limit: 65535,             null: false
    t.integer  "state",                         default: 1, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["binder_key"], name: "fk_rails_df8959742e", using: :btree
    t.index ["history_id"], name: "index_reports_on_history_id", using: :btree
    t.index ["user_id"], name: "index_reports_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "histories", "binders"
  add_foreign_key "reports", "binders", column: "binder_key", primary_key: "key"
  add_foreign_key "reports", "users"
end
