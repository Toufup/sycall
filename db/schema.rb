# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_07_130412) do

  create_table "artists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "lyrics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "lyrics_version_id", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lyrics_version_id"], name: "index_lyrics_on_lyrics_version_id"
  end

  create_table "lyrics_versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "source", null: false
    t.bigint "song_id", null: false
    t.bigint "language_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_lyrics_versions_on_language_id"
    t.index ["song_id"], name: "index_lyrics_versions_on_song_id"
  end

  create_table "songs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bpm"
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "url", null: false
    t.integer "type", null: false
    t.bigint "lyrics_version_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lyrics_version_id"], name: "index_videos_on_lyrics_version_id"
    t.index ["url"], name: "index_videos_on_url", unique: true
  end

  add_foreign_key "lyrics", "lyrics_versions"
  add_foreign_key "lyrics_versions", "languages"
  add_foreign_key "lyrics_versions", "songs"
  add_foreign_key "songs", "artists"
  add_foreign_key "videos", "lyrics_versions"
end
