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

ActiveRecord::Schema.define(version: 2022_04_11_230509) do

  create_table "decks", force: :cascade do |t|
    t.string "language"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flashcards", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "front"
    t.string "back"
    t.integer "scaled_frequency"
    t.integer "frequency_rank"
    t.string "term_collocation_test"
    t.string "question"
    t.string "answer"
    t.string "term_with_accent"
    t.string "distinguishing_grammatical_info"
    t.string "conjugation_and_declension_info"
    t.string "top_three_grammatical_collocations"
    t.string "definition_being_tested"
    t.string "other_definitions"
    t.string "source_sentence"
    t.string "target_sentence"
    t.string "sentence_source"
    t.string "other_sentence_pairs"
    t.string "other_sentence_pairs_both"
    t.integer "deck_id", null: false
    t.string "test_direction"
    t.index ["deck_id"], name: "index_flashcards_on_deck_id"
  end

  create_table "user_decks", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "language"
    t.integer "deck_id", null: false
    t.integer "user_id", null: false
    t.integer "to_learn_per_day"
    t.index ["deck_id", "user_id"], name: "index_user_decks_on_deck_id_and_user_id", unique: true
    t.index ["deck_id"], name: "index_user_decks_on_deck_id"
    t.index ["user_id"], name: "index_user_decks_on_user_id"
  end

  create_table "user_flashcards", force: :cascade do |t|
    t.datetime "next_review"
    t.datetime "due_to_learn"
    t.datetime "learnt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_deck_id"
    t.integer "flashcard_id"
    t.datetime "previous_review"
    t.boolean "lapsed"
    t.boolean "ignore"
    t.index ["flashcard_id"], name: "index_user_flashcards_on_flashcard_id"
    t.index ["user_deck_id"], name: "index_user_flashcards_on_user_deck_id"
  end

  create_table "users", force: :cascade do |t|
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

  add_foreign_key "flashcards", "decks"
  add_foreign_key "user_decks", "decks"
  add_foreign_key "user_decks", "users"
  add_foreign_key "user_flashcards", "flashcards"
  add_foreign_key "user_flashcards", "user_decks"
end
