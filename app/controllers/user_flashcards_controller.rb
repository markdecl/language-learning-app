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
    # params[:next_review] = Time.now

    @user_flashcard.update(previous_review: Time.now) # set as current date and time
    # @user_flashcard.update(next_review: Time.now + (24*60*60)) # set as current date and time plus 1 day
    @user_flashcard.update(next_review: Time.now + (60)) # set as current date and time plus 1 minute

    # redirect_to @user_deck
    # user_deck = UserDeck.find(params[:user_deck_id])
    redirect_to user_deck_learn_path(@user_flashcard.user_deck_id)
  end

  def update_review
    answer_correct = params[:answer_correct]
    @user_flashcard = UserFlashcard.find(params[:id])
    previous_review = @user_flashcard.previous_review
    next_review = @user_flashcard.next_review
    if answer_correct
      @user_flashcard.update(next_review: next_review + ((next_review - previous_review) * 2.5)) # multiplies by 2.5
    else
      @user_flashcard.update(next_review: next_review + ((next_review - previous_review) * 0.4)) # multiplies by 0.4
    end
    @user_flashcard.update(previous_review: next_review)
    # redirect_to user_flashcard_path(@user_flashcard)
    redirect_to user_deck_review_path(@user_flashcard.user_deck_id)
  end

  private

  def user_flashcard_params
    params.require(:user_flashcard)
  end
  # ^ what does this do?

end
