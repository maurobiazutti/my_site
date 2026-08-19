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

ActiveRecord::Schema[8.1].define(version: 2026_08_19_020619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articles", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.text "excerpt"
    t.datetime "published_at"
    t.string "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.text "message"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "comments", "articles"
  add_foreign_key "sessions", "users"
end
