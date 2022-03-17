class UserDeck < ApplicationRecord
  has_many :user_flashcards, dependent: :destroy
  validates_uniqueness_of :deck_id#, scope: [:survey_id]
end
