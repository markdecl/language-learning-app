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

  def update_learn
    @user_flashcard = UserFlashcard.find(params[:id])
    # params[:learnt] = true
    @user_flashcard.update(learnt: true)
    # params[:next_review] = Time.now # add spaced repetition algorithm to this

    @user_flashcard.update(next_review: Time.now) # set as current date and time
    # @user_flashcard.update(next_review: Time.now + (24*60*60)) # add 1 day

    # redirect_to @user_deck
    # user_deck = UserDeck.find(params[:user_deck_id])
    redirect_to user_deck_learn_path(@user_flashcard.user_deck_id)
  end

  def update_review
    @user_flashcard = UserFlashcard.find(params[:id])
    next_review = @user_flashcard.next_review
    @user_flashcard.update(next_review: next_review + (24*60*60)) # add 1 day)
    # redirect_to user_flashcard_path(@user_flashcard)
    redirect_to user_deck_review_path(@user_flashcard.user_deck_id)
  end

  private

  def user_flashcard_params
    params.require(:user_flashcard)
  end

end
