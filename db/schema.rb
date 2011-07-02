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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110702035152) do

  create_table "contact_logs", :force => true do |t|
    t.string   "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "typo",         :default => "wenba"
    t.string   "name"
    t.string   "gender"
    t.date     "birth"
    t.string   "wedding"
    t.string   "address"
    t.string   "email"
    t.string   "qq"
    t.string   "phone"
    t.text     "content"
    t.string   "is_processed", :default => "n"
    t.string   "processed_by"
    t.text     "note"
    t.string   "is_visiable",  :default => "y"
    t.string   "is_destroy",   :default => "n"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "seo_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "is_exported", :limit => 1, :default => "n"
  end

  create_table "pictures", :force => true do |t|
    t.integer  "page_id"
    t.string   "global_path"
    t.string   "shortcut_path"
    t.string   "title"
    t.string   "summary"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
