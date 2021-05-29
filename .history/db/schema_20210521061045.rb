ActiveRecord::Schema.define(version: 2021_05_19_112452) do

  create_table "areas", force: :cascade do |t|
    t.string "name"
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
    t.text "feature", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "season_id"
    t.index ["season_id"], name: "index_flower_items_on_season_id"
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

  create_table "spots", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.text "feature", null: false
    t.string "image"
    t.string "url"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "area_id"
    t.index ["area_id"], name: "index_spots_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_name"
    t.text "self_introduction"
    t.string "profile_image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "flower_item_spots", "flower_items"
  add_foreign_key "flower_item_spots", "spots"
  add_foreign_key "flower_items", "seasons"
  add_foreign_key "spots", "areas"
end
