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

ActiveRecord::Schema.define(version: 2022_02_24_180240) do

  create_table "flashcards", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "front"
    t.string "back"
  end

  create_table "user_decks", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "language"
  end

  create_table "user_flashcards", force: :cascade do |t|
    t.datetime "next_review"
    t.datetime "due_to_learn"
    t.boolean "learnt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_deck_id"
    t.integer "flashcard_id"
    t.index ["flashcard_id"], name: "index_user_flashcards_on_flashcard_id"
    t.index ["user_deck_id"], name: "index_user_flashcards_on_user_deck_id"
  end

  add_foreign_key "user_flashcards", "flashcards"
  add_foreign_key "user_flashcards", "user_decks"
end
