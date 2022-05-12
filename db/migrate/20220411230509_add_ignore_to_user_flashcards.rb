class AddIgnoreToUserFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :user_flashcards, :ignore, :boolean
  end
end
