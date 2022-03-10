class UserDecksController < ApplicationController
  def index
    @decks = Deck.all
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

  def new
  end

  def create
    @user_deck = UserDeck.new({deck_id: user_deck_params}) # user_deck_params is just the id as a string for some reason
    if @user_deck.save
      # BUILD THE LOGIC TO CREATE THE USER_FLASHCARDS ASSOCIATED WITH THE NEW DECK TOO:
      @deck_flashcards = Flashcard.where(deck_id: user_deck_params) # user_deck_params is just the id as a string for some reason
      @deck_flashcards.each do |deck_flashcard|
        attributes = {user_deck_id: @user_deck.id, flashcard_id: deck_flashcard.id, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false}
        user_flashcard = UserFlashcard.create!(attributes)
        #puts "Created #{user_flashcard}"
      end
      #redirect_to user_deck_path(@user_deck)
      redirect_to user_decks_path
    else
      #render :new
      #redirect_to decks_path, notice: "Deck already added!"
      flash[:alert] = "Deck already added!"
      redirect_to decks_path
    end
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
    # @answer_checked = params[:answer_checked]
    # @answer_correct = params[:answer_correct]
    # @flashcards = Flashcard.where(id: @user_deck_flashcards.ids)
  end
  helper_method :review # dunno if this should be here. Supposed to help render the review pile count in index.html.erb

  def review_answer
    # @user_deck = UserDeck.find(params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id, learnt: true)
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id, learnt: true, next_review: < Time.now)
    # @user_deck_flashcards = UserFlashcard.where("user_deck_id = ? AND learnt = ? AND next_review < ?", @user_deck.id, true, Time.now)
    @flashcards = Flashcard.all
    # @answer_checked = params[:answer_checked]
    # @answer_correct = params[:answer_correct]
    # @flashcards = Flashcard.where(id: @user_deck_flashcards.ids)
    @user_flashcard = UserFlashcard.find(params[:id])
  end


  # def show_answer
  # respond_to do |format|
  #     format.html {}
  #     format.js
  #   end
  # end

  # def edit_review_time
  # end

  def destroy
    # fetch user_deck to destroy from DB
    user_deck = UserDeck.find(params[:id])
    # destroy record
    user_deck.destroy
    #user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id)
    #user_deck_flashcards.destroy
    # redirect to index
    redirect_to user_decks_path
  end

  def user_deck_params
    params.require(:deck_id)#.permit(:name, :address, :stars)
    #params.require(:user_deck)#.permit(:name, :address, :stars)
  end

end
