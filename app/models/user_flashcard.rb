class UserFlashcard < ApplicationRecord
  belongs_to :user_deck
  belongs_to :flashcard
end
