class UserFlashcardsController < ApplicationController

  def index
    @flashcards = Flashcard.all
    # @user_deck = UserDeck.find(params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id)
    # @flashcards = Flashcard.all
  end

  def create
    @user_flashcard = UserFlashcard.new(user_flashcard_params)
    if @user_flashcard.save
      redirect_to user_flashcard_path(@user_flashcard)
    else
      render :new
    end
  end
end
