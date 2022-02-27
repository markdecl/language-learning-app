Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'user_decks#index'

  # resources :user_decks do
  #   resources :user_flashcards
  # end

  resources :user_decks
  resources :user_flashcards

  # get "/user_decks", to: "user_decks#index", as: :user_decks
  # get    "/user_decks/:id",      to: "user_decks#show",   as: :user_deck

  # get    "/user_decks/:id/review",      to: "user_decks#review",   as: :user_deck_review

  resources :flashcards
  # get    "/flashcards",          to: "flashcards#index",  as: :flashcards
  # get    "/flashcards/new",      to: "flashcards#new",    as: :new_flashcard
  # post   "/flashcards",          to: "flashcards#create"
  # get    "/flashcards/:id",      to: "flashcards#show",   as: :flashcard
  # get    "/flashcards/:id/edit", to: "flashcards#edit",   as: :edit_flashcard
  # patch  "/flashcards/:id",      to: "flashcards#update"
  # delete "/flashcards/:id",      to: "flashcards#destroy"
end
