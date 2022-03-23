Rails.application.routes.draw do
  # devise_for :users
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy' # to make navbar 'Log out' link work
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root to: 'user_decks#index'
  root to: 'static_pages#home'

  # resources :user_decks do
  #   resources :user_flashcards
  # end

  resources :decks

  resources :user_decks
  get "/user_decks/:id/learn", to: "user_decks#learn", as: :user_deck_learn
  get "/user_decks/:id/get_learning_schedule", to: "user_decks#get_learning_schedule", as: :get_learning_schedule
  post "/user_decks/:id/get_learning_schedule", to: "user_decks#update_learning_schedule", as: :update_learning_schedule
  get "/user_decks/:id/review", to: "user_decks#review", as: :user_deck_review
  get "/user_flashcards/:id/review_answer", to: "user_decks#review_answer", as: :user_deck_review_answer
  # patch "/user_decks", to: "user_decks#open_delete_modal", as: :user_deck_open_delete_modal
  # get 'show_answer', to: 'user_decks#show_answer'

  resources :user_flashcards
  resources :user_flashcards do
    member do
      patch :update_learn
      patch :update_review
      # patch :check_answer
      # patch :update_learn, to: "user_decks#learn", as: :update_learn
    end
  end
  patch "/user_flashcards/:id/review_answer", to: "user_flashcards#check_answer", as: :check_answer_user_flashcard

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
