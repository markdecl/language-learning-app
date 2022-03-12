class UserFlashcardsController < ApplicationController

  def index
    @user_flashcards = UserFlashcard.all
    # @user_deck = UserDeck.find(params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id)
    # @flashcards = Flashcard.all
  end

  def new
  end

  def create
    @user_flashcard = UserFlashcard.new(user_flashcard_params)
    if @user_flashcard.save
      redirect_to user_flashcard_path(@user_flashcard)
    else
      render :new
    end
  end

  def check_answer
    @user_flashcard = UserFlashcard.find(params[:id])
    # @flashcard = Flashcard.find(@user_flashcard.flashcard_id)
    # @user_answer = params(:user_answer)
    # @top_user_flashcard = params(top_user_flashcard)

    if @user_answer == @user_flashcard.flashcard.answer
      answer_correct = true
    else
      answer_correct = false
    end
    # answer_correct = (@user_answer == @user_flashcard.flashcard.answer)

    # redirect_to user_deck_review_answer_path(@user_flashcard.user_deck_id, user_answer: @user_answer, answer_checked: true, answer_correct: answer_correct)
    # redirect_to user_deck_review_answer_path(@user_flashcard, user_answer: @user_answer, answer_checked: true, answer_correct: answer_correct)
    redirect_to user_deck_review_answer_path(@user_flashcard, user_answer: @user_answer, answer_correct: answer_correct)
  end

  def update_learn
    @user_flashcard = UserFlashcard.find(params[:id])
    # params[:learnt] = true
    @user_flashcard.update(learnt: true)
    # params[:next_review] = Time.now

    @user_flashcard.update(previous_review: Time.now) # set as current date and time

    @user_flashcard.update(next_review: Time.now + (10)) # set as current date and time plus 10 seconds (for testing purposes)
    # @user_flashcard.update(next_review: Time.now + (60)) # set as current date and time plus 1 minute (for testing purposes)
    # @user_flashcard.update(next_review: Time.now + (24*60*60)) # set as current date and time plus 1 day

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
      # @user_flashcard.update(next_review: next_review + ((next_review - previous_review) * 2.5)) # multiplies by 2.5
      @user_flashcard.update(next_review: Time.now + ((Time.now - previous_review) * 2.5)) # multiplies time interval between previous review and NOW by 2.5
    else
      # @user_flashcard.update(next_review: next_review + ((next_review - previous_review) * 0.4)) # multiplies by 0.4
      @user_flashcard.update(next_review: Time.now + ((Time.now - previous_review) * 0.4)) # multiplies time interval between previous review and NOW by 0.4
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
