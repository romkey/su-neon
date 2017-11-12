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

ActiveRecord::Schema.define(version: 20171111191642) do

  create_table "configs", force: :cascade do |t|
    t.string "particle_access_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "threshold"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "normalized", null: false
    t.index ["name"], name: "index_keywords_on_name"
    t.index ["normalized"], name: "index_keywords_on_normalized"
  end

  create_table "keywords_signs", id: false, force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "sign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_keywords_signs_on_keyword_id"
    t.index ["sign_id"], name: "index_keywords_signs_on_sign_id"
  end

  create_table "ml_dictionaries", force: :cascade do |t|
    t.string "word", null: false
    t.index ["word"], name: "index_ml_dictionaries_on_word"
  end

  create_table "news_hits", force: :cascade do |t|
    t.integer "news_source_id", null: false
    t.integer "keyword_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_news_hits_on_keyword_id"
    t.index ["news_source_id"], name: "index_news_hits_on_news_source_id"
  end

  create_table "news_sources", force: :cascade do |t|
    t.string "name", null: false
    t.string "feed_url", null: false
    t.integer "lifetime_hits", default: 0, null: false
    t.datetime "last_processed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "image_url"
    t.string "profile_url"
    t.string "access_token"
    t.text "raw_data"
    t.index ["user_id"], name: "index_oauth_accounts_on_user_id"
  end

  create_table "particle_instances", force: :cascade do |t|
    t.string "name", null: false
    t.string "particle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_particles_on_name"
  end

  create_table "recent_headlines", force: :cascade do |t|
    t.string "headline", null: false
    t.integer "news_source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link", default: "", null: false
    t.index ["news_source_id"], name: "index_recent_headlines_on_news_source_id"
  end

  create_table "signs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "particle_instance_id"
    t.integer "relay", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.boolean "lit", default: false, null: false
    t.integer "order", default: 0, null: false
    t.index ["name"], name: "index_signs_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
