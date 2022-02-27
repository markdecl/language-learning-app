class UserDecksController < ApplicationController
  def index
    @user_decks = UserDeck.all
  end

  def learn
  end

  def review
    @user_deck = UserDeck.find(params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: params[:id])
    @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id)
    @flashcards = Flashcard.all
    # @flashcards = Flashcard.where(id: @user_deck_flashcards.ids)
  end

  def edit_review_time
  end

  def create
    @user_deck = UserDeck.new(user_deck_params)
    if @user_deck.save
      redirect_to user_deck_path(@user_deck)
    else
      render :new
    end
  end

end
