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

ActiveRecord::Schema.define(version: 20180714114529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_auth_accounts_on_name", unique: true
  end

  create_table "auth_usernames", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.bigint "auth_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_user_id"], name: "index_auth_usernames_on_auth_user_id"
    t.index ["name"], name: "index_auth_usernames_on_name", unique: true
  end

  create_table "auth_users", force: :cascade do |t|
    t.string "email"
    t.bigint "auth_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "auth_username_id"
    t.string "external_id"
    t.index ["auth_account_id"], name: "index_auth_users_on_auth_account_id"
    t.index ["email"], name: "index_auth_users_on_email", unique: true
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "app_id"
    t.index ["app_id", "name"], name: "index_collections_on_app_id_and_name", unique: true
  end

  create_table "collections_pages", id: false, force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "collection_id", null: false
    t.index ["page_id", "collection_id"], name: "index_collections_pages_on_page_id_and_collection_id"
  end

  create_table "component_options", force: :cascade do |t|
    t.integer "xs_width"
    t.string "conditional_render"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.string "app_id"
    t.integer "collection_id"
    t.integer "element_id"
    t.string "element_type"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id", "name"], name: "index_components_on_app_id_and_name", unique: true
    t.index ["collection_id"], name: "index_components_on_collection_id"
  end

  create_table "components_pages", id: false, force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "component_id", null: false
    t.index ["page_id", "component_id"], name: "index_components_pages_on_page_id_and_component_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "name"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "version"
  end

  create_table "customer_apps", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "auth_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_account_id"], name: "index_customer_apps_on_auth_account_id"
  end

  create_table "dividers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hyperlinks", force: :cascade do |t|
    t.string "url"
    t.string "text"
    t.string "target"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "route"
    t.bigint "customer_app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_app_id"], name: "index_pages_on_customer_app_id"
  end

  create_table "paragraphs", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spacers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_titles", force: :cascade do |t|
    t.string "text"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bottom_divider"
    t.boolean "top_divider"
    t.boolean "inset"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "template_elements", force: :cascade do |t|
    t.string "element_type"
    t.integer "ordinal"
    t.bigint "template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_template_elements_on_template_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_templates_on_name", unique: true
  end

  create_table "titles", force: :cascade do |t|
    t.string "text"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "auth_usernames", "auth_users"
  add_foreign_key "auth_users", "auth_accounts"
end
