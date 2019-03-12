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

ActiveRecord::Schema.define(version: 2019_03_12_144823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_countries_on_product_id"
  end

  create_table "designs", force: :cascade do |t|
    t.bigint "product_id"
    t.json "datas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_designs_on_product_id"
  end

  create_table "emissions", force: :cascade do |t|
    t.string "cas"
    t.float "quantity"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_name"
    t.index ["product_id"], name: "index_emissions_on_product_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "cas"
    t.float "quantity"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "datas"
    t.string "file_name"
    t.string "product_identification"
    t.index ["product_id"], name: "index_ingredients_on_product_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.bigint "product_id"
    t.json "datas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_presentations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.json "datas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ref"
    t.string "submitter_file_name"
    t.string "manufacturer_file_name"
    t.string "design_file_name"
    t.string "presentation_file_name"
    t.string "uuid"
    t.string "nicotine_dose_uptake_file"
    t.string "consistent_dosing_methods_file"
  end

  add_foreign_key "countries", "products"
  add_foreign_key "designs", "products"
  add_foreign_key "emissions", "products"
  add_foreign_key "ingredients", "products"
  add_foreign_key "presentations", "products"
end
