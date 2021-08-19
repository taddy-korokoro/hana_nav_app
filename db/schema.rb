# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_18_114950) do

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id"
    t.integer "travel_record_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "spot_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flower_item_seasons", force: :cascade do |t|
    t.integer "flower_item_id", null: false
    t.integer "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flower_item_spots", force: :cascade do |t|
    t.integer "spot_id", null: false
    t.integer "flower_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flower_items", force: :cascade do |t|
    t.string "name", null: false
    t.text "time", null: false
    t.text "feature", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "travel_record_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "following_id"
    t.integer "follower_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id", "following_id"], name: "index_relationships_on_follower_id_and_following_id", unique: true
  end

  create_table "scrapings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "month_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spot_seasons", force: :cascade do |t|
    t.integer "spot_id", null: false
    t.integer "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spots", force: :cascade do |t|
    t.string "name", null: false
    t.string "time"
    t.string "location"
    t.text "feature"
    t.string "image"
    t.string "url"
    t.float "latitude"
    t.float "longitude"
    t.integer "area_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_spots_on_area_id"
  end

  create_table "travel_records", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "place"
    t.float "review", default: 0.0
    t.date "visited_on"
    t.string "image_1"
    t.string "image_2"
    t.string "image_3"
    t.float "latitude"
    t.float "longitude"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "spot_id"
    t.index ["spot_id"], name: "index_travel_records_on_spot_id"
    t.index ["user_id"], name: "index_travel_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.text "self_introduction"
    t.string "profile_image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "flower_item_seasons", "flower_items"
  add_foreign_key "flower_item_seasons", "seasons"
  add_foreign_key "flower_item_spots", "flower_items"
  add_foreign_key "flower_item_spots", "spots"
  add_foreign_key "spot_seasons", "seasons"
  add_foreign_key "spot_seasons", "spots"
  add_foreign_key "spots", "areas"
  add_foreign_key "travel_records", "spots"
  add_foreign_key "travel_records", "users"
end
