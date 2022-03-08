class DecksController < ApplicationController

  def index
    @decks = Deck.all
    @flashcards = Flashcard.all
  end

  def show
    @deck = Deck.find(params[:id])
    @deck_flashcards = Flashcard.where(user_deck_id: @deck.id)
    @flashcards = Flashcard.all
  end
end
