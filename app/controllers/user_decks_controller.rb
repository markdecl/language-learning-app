class UserDecksController < ApplicationController
  def index
    @user_decks = UserDeck.all
    @user_flashcards = UserFlashcard.all
  end

  # def number_to_review

  # end
  # helper_method :number_to_review

  def show
    @user_deck = UserDeck.find(params[:id])
    @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id)
    @flashcards = Flashcard.all
  end

  def learn
    @user_deck = UserDeck.find(params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: params[:id])
    @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id, learnt: false)
    @flashcards = Flashcard.all
    # @flashcards = Flashcard.where(id: @user_deck_flashcards.ids)
  end

  def review
    @user_deck = UserDeck.find(params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id, learnt: true)
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id, learnt: true, next_review: < Time.now)
    @user_deck_flashcards = UserFlashcard.where("user_deck_id = ? AND learnt = ? AND next_review < ?", @user_deck.id, true, Time.now)
    @flashcards = Flashcard.all
    # @flashcards = Flashcard.where(id: @user_deck_flashcards.ids)
  end
  helper_method :review # dunno if this should be here. Supposed to help render the review pile count in index.html.erb

  # def show_answer
  # respond_to do |format|
  #     format.html {}
  #     format.js
  #   end
  # end

  # def edit_review_time
  # end

  def create
    @user_deck = UserDeck.new(user_deck_params)
    if @user_deck.save
      redirect_to user_deck_path(@user_deck)
    else
      render :new
    end
  end

end
