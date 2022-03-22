class UserDecksController < ApplicationController
  def index
    @decks = Deck.all
    @user_decks = UserDeck.where(user_id: current_user.id)
    @user_flashcards = UserFlashcard.all
  end

  # def number_to_review

  # end
  # helper_method :number_to_review

  def show
    @user_deck = UserDeck.find(params[:id])
    @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id).order('due_to_learn')
    # @user_deck_flashcards = UserFlashcard.find(:all, :conditions => [ "user_deck_id = ?", @user_deck.id], :joins=>:flashcard, :order=>'flashcards.scaled_frequency DESC' )
    # @user_deck_flashcards = UserFlashcard.find(:all, :conditions => [ "user_deck_id = ?", @user_deck.id], :order=>'flashcards.scaled_frequency DESC' )
    # @user_deck_flashcards = UserFlashcard.find(:all, :conditions => [ "user_deck_id = ?", @user_deck.id] )
    # @user_deck_flashcards = @user_deck_flashcards.find(:all,:joins=>:flashcard, :order=>'flashcards.scaled_frequency DESC' )
    @flashcards = Flashcard.where(deck_id: @user_deck.deck_id)

    # @flashcards_joined = Flashcard.includes(:user_flashcards).order(scaled_frequency: :desc)
    # @flashcards_ordered = Flashcard.includes(:user_flashcards).order(scaled_frequency: :desc)
    @flashcards_ordered = Flashcard.includes(:user_flashcards)
    # @flashcards_joined = UserFlashcard.joins(:flashcard)
    # @flashcards_joined = Flashcard.joins("INNER JOIN user_flashcards ON user_flashcards.flashcard_id = flashcards.id")
  end

  def new
  end

  def create
    deck_id = params[:deck_id]
    @deck = Deck.find(deck_id)
    # @deck = Deck.find(user_deck_params) # user_deck_params is just the deck_id as a string for some reason
    @user_deck = UserDeck.new({deck_id: deck_id})
    # @user_deck = UserDeck.new({deck_id: user_deck_params}) # user_deck_params is just the deck_id as a string for some reason
    # @user_deck.id = @deck.id # this ensures that the user_deck is the same as the deck_id, in case multiple user_decks are created and destroyed, leading to misalignment between the two tables. UPDATE: but this breaks when multiple users try to add the same deck.
    @user_deck.user_id = current_user.id
    if @user_deck.save
      # BUILD THE LOGIC TO CREATE THE USER_FLASHCARDS ASSOCIATED WITH THE NEW DECK TOO:
      @deck_flashcards = Flashcard.where(deck_id: deck_id).order('scaled_frequency DESC')
      # @deck_flashcards = Flashcard.where(deck_id: user_deck_params).order('scaled_frequency DESC') # user_deck_params is just the deck_id as a string for some reason
      # Set the due_to_learn attribute for every 100 user_flashcards as that of the previous 100 cards + 1 day
      # due_to_learn = Time.now
      # user_flashcard_index = 1
      @deck_flashcards.each do |deck_flashcard|
        # attributes = {user_deck_id: @user_deck.id, flashcard_id: deck_flashcard.id, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false}
        attributes = {user_deck_id: @user_deck.id, flashcard_id: deck_flashcard.id, next_review: nil, learnt: nil, due_to_learn: nil} # due_to_learn is set to nil for the time being
        user_flashcard = UserFlashcard.create!(attributes)
        #puts "Created #{user_flashcard}"
        # user_flashcard_index += 1
        # if user_flashcard_index > 100
          # due_to_learn += (24 * 60 * 60)
          # user_flashcard_index = 1
        # end
      end
      redirect_to get_learning_schedule_path(@user_deck)
      #redirect_to user_deck_path(@user_deck)
      flash[:alert] = "#{@deck.language} deck added!"
      # redirect_to user_decks_path
    else
      #render :new
      #redirect_to decks_path, notice: "Deck already added!"
      flash[:alert] = "Deck already added!"
      redirect_to decks_path
    end
  end

  def get_learning_schedule
    @user_deck = UserDeck.find(user_deck_params)
  end

  def update_learning_schedule
    @user_deck = UserDeck.find(params[:id])
    @user_deck_flashcards = UserFlashcard.where("user_deck_id = ? AND learnt IS ?", @user_deck.id, nil)
    due_to_learn = Time.now
    to_learn_per_day = params[:to_learn_per_day].to_i
    user_flashcard_index = 1
    @user_deck_flashcards.each do |user_deck_flashcard|
      # attributes = {user_deck_id: @user_deck.id, flashcard_id: deck_flashcard.id, next_review: "2022-02-26 00:00:00", due_to_learn: "2022-02-26 00:00:00", learnt: false}
      # attributes = {user_deck_id: @user_deck.id, flashcard_id: user_deck_flashcard.id, next_review: nil, learnt: nil, due_to_learn: due_to_learn}
      # user_flashcard = UserFlashcard.create!(attributes)
      user_deck_flashcard.update(due_to_learn: due_to_learn)
      #puts "Created #{user_flashcard}"
      user_flashcard_index += 1
      if user_flashcard_index > to_learn_per_day.to_i
        due_to_learn += (24 * 60 * 60)
        user_flashcard_index = 1
      end
    end
    flash[:alert] = "Deck learning schedule updated!"
    redirect_to user_decks_path
  end

  def learn
    @user_deck = UserDeck.find(params[:id])
    @deck = Deck.find(@user_deck.deck_id)
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: params[:id])
    @user_deck_flashcards = UserFlashcard.where("user_deck_id = ? AND learnt IS ? AND due_to_learn <= ?", @user_deck.id, nil, Time.now)
    # @flashcards = Flashcard.all#.order(scaled_frequency: :desc)
    # @flashcards = Flashcard.where(id: @user_deck_flashcards.ids)
    if @user_deck_flashcards.any?
      @top_user_flashcard = @user_deck_flashcards.sort_by{ |flashcard| flashcard[:due_to_learn] }.first
      @top_flashcard = Flashcard.find(@top_user_flashcard.flashcard_id)
    else
      # @top_user_flashcard = nil
      # @top_flashcard = nil
      flash[:alert] = "Congrats! You've completed your daily learning goal for the #{@deck.language} deck."
      redirect_to user_decks_path
    end
  end

  def review
    @user_deck = UserDeck.find(params[:id])
    @deck = Deck.find(@user_deck.deck_id)
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: params[:id])
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id, learnt: true)
    # @user_deck_flashcards = UserFlashcard.where(user_deck_id: @user_deck.id, learnt: true, next_review: < Time.now)
    # @user_deck_flashcards = UserFlashcard.where("user_deck_id = ? AND learnt IS NOT ? AND next_review <= ?", @user_deck.id, nil, Time.now) # current time or earlier
    @user_deck_flashcards = UserFlashcard.where("user_deck_id = ? AND learnt IS NOT ? AND next_review <= ?", @user_deck.id, nil, DateTime.now.utc.end_of_day) # end of today or earlier
    # @flashcards = Flashcard.all
    # @answer_checked = params[:answer_checked]
    # @answer_correct = params[:answer_correct]
    # @flashcards = Flashcard.where(id: @user_deck_flashcards.ids)
    if @user_deck_flashcards.any?
      @top_user_flashcard = @user_deck_flashcards.sort_by{ |flashcard| flashcard[:next_review] }.first
      @top_flashcard = Flashcard.find(@top_user_flashcard.flashcard_id)
    else
      # @top_user_flashcard = nil
      # @top_flashcard = nil
      flash[:alert] = "Congrats! You've caught up on the #{@deck.language} deck reviews."
      redirect_to user_decks_path
    end
  end
  helper_method :review # dunno if this should be here. Supposed to help render the review pile count in index.html.erb.

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
    @user_answer = params[:user_answer]
    @answer_correct = params[:answer_correct]
  end


  # def show_answer
  # respond_to do |format|
  #     format.html {}
  #     format.js
  #   end
  # end

  # def edit_review_time
  # end

  # def open_delete_modal
  #   @user_deck = UserDeck.find(params[:id])
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
    params.fetch(:id, :deck_id)
    # params.require(:id)#.permit(:name, :address, :stars)
    #params.require(:user_deck)#.permit(:name, :address, :stars)
  end

end
