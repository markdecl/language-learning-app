class FlashcardsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
  end

  def index
    @flashcards = Flashcard.all
  end
end
