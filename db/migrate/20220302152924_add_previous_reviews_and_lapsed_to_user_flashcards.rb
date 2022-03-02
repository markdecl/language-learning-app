class AddPreviousReviewsAndLapsedToUserFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :user_flashcards, :previous_review, :datetime
    add_column :user_flashcards, :lapsed, :boolean
  end
end
