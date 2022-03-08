class Deck < ApplicationRecord
  has_many :flashcards
  has_many :user_decks
end
