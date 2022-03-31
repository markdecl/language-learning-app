class DecksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @decks = Deck.all
    @user_deck_ids = UserDeck.where(user_id: current_user.id).pluck("deck_id")
    @flashcards = Flashcard.all
  end

  def show
    @deck = Deck.find(params[:id])
    @deck_flashcards = Flashcard.where(user_deck_id: @deck.id)
    @flashcards = Flashcard.all
  end

end
