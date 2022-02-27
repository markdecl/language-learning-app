class AddUserDeckAndFlashcardFkColsToUserFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_flashcards, :user_deck, foreign_key: true
    add_reference :user_flashcards, :flashcard, foreign_key: true
  end
end
