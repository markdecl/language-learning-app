class AddFrontAndBackToFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :flashcards, :front, :string
    add_column :flashcards, :back, :string
  end
end
