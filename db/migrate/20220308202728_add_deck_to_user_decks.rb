class AddDeckToUserDecks < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_decks, :deck, null: false, foreign_key: true, unique: true
  end
end
