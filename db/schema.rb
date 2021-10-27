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

ActiveRecord::Schema.define(version: 2021_10_27_024315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "castles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "population"
    t.integer "gold_worker"
    t.integer "farm_worker"
    t.integer "wood_worker"
    t.integer "stone_worker"
    t.integer "iron_worker"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "army"
    t.integer "idle_population"
    t.index ["user_id"], name: "index_castles_on_user_id"
  end

  create_table "castles_games", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "castle_id", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.integer "created_by"
    t.integer "player_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "started"
    t.boolean "finished"
  end

  create_table "games_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.string "color"
    t.integer "win"
    t.integer "lost"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "current_game"
    t.string "capital"
  end

end
