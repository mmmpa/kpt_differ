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

ActiveRecord::Schema.define(version: 20170422000003) do

  create_table "binders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "hex",         null: false
    t.integer  "group_id",    null: false
    t.string   "key",         null: false
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["group_id"], name: "index_binders_on_group_id", using: :btree
    t.index ["key", "group_id"], name: "index_binders_on_key_and_group_id", unique: true, using: :btree
  end

  create_table "group_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "hex",        null: false
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id", using: :btree
    t.index ["user_id"], name: "index_group_users_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "hex",                     null: false
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "hex",        null: false
    t.integer  "binder_id",  null: false
    t.string   "binder_key", null: false
    t.integer  "state",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["binder_id"], name: "index_histories_on_binder_id", using: :btree
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "hex",                                        null: false
    t.integer  "user_id",                                    null: false
    t.integer  "binder_id",                                  null: false
    t.string   "binder_key",                                 null: false
    t.integer  "history_id",                                 null: false
    t.integer  "newer_report_id"
    t.integer  "older_report_id"
    t.string   "title",                         default: "", null: false
    t.text     "body",            limit: 65535,              null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["binder_id"], name: "index_reports_on_binder_id", using: :btree
    t.index ["history_id"], name: "index_reports_on_history_id", using: :btree
    t.index ["newer_report_id"], name: "fk_rails_183c1b57c3", using: :btree
    t.index ["older_report_id"], name: "fk_rails_4835dba508", using: :btree
    t.index ["user_id"], name: "index_reports_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "hex",                     null: false
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_foreign_key "binders", "groups"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "histories", "binders"
  add_foreign_key "reports", "binders"
  add_foreign_key "reports", "histories"
  add_foreign_key "reports", "reports", column: "newer_report_id"
  add_foreign_key "reports", "reports", column: "older_report_id"
  add_foreign_key "reports", "users"
end
