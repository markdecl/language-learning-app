class UserDeck < ApplicationRecord
  has_many :user_flashcards, dependent: :destroy
  validates_uniqueness_of :deck_id, scope: :user_id
end
