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

ActiveRecord::Schema.define(version: 20170715171250) do

  create_table "Sets", primary_key: "ID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "NAME", limit: 50, null: false
    t.string "CODE", limit: 5, null: false
    t.string "GATHERERCODE", limit: 5
    t.string "OLDCODE", limit: 5
    t.string "RELEASEDATE", limit: 10
    t.string "BORDER", limit: 5
    t.string "TYPE", limit: 15
    t.string "BLOCK", limit: 50
    t.boolean "ONLINEONLY"
    t.string "BOOSTER", limit: 25
  end

  create_table "card_set_relations", primary_key: "ID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "set_id"
    t.integer "card_id"
    t.integer "multiverseid"
  end

  create_table "card_set_relations_old", primary_key: "ID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "set_id"
    t.integer "card_id"
    t.integer "multiverseid"
  end

  create_table "cards", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 50
    t.string "MANACOST", limit: 15
    t.integer "CMC"
    t.string "COLORS", limit: 5
    t.string "TYPE", limit: 50
    t.string "RARITY", limit: 15
    t.integer "POWER"
    t.integer "TOUGHNESS"
    t.integer "MULTIVERSEID"
    t.string "IMAGENAME", limit: 50
  end

  create_table "categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.integer "rev_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "text", limit: 4000, null: false
  end

  create_table "database_structures", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
  end

  create_table "dcrs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "amount", null: false
    t.integer "rev_id", null: false
    t.integer "card_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sb", default: 0
  end

  create_table "decks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "format", limit: 20, null: false
    t.integer "user_id", null: false
  end

  create_table "revs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean "physical", null: false
    t.integer "rev_nr", null: false
    t.integer "deck_id", null: false
    t.string "name", limit: 50, null: false
    t.integer "user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "setsBackup", primary_key: "ID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "NAME", limit: 50, null: false
    t.string "CODE", limit: 5, null: false
    t.string "GATHERERCODE", limit: 5
    t.string "OLDCODE", limit: 5
    t.string "RELEASEDATE", limit: 10
    t.string "BORDER", limit: 5
    t.string "TYPE", limit: 15
    t.string "BLOCK", limit: 50
    t.boolean "ONLINEONLY"
    t.string "BOOSTER", limit: 25
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 50, null: false
    t.string "email", null: false
    t.string "password_digest", limit: 2048, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

end
