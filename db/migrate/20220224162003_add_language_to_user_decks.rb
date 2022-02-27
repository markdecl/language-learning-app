class AddLanguageToUserDecks < ActiveRecord::Migration[6.0]
  def change
    add_column :user_decks, :language, :string
  end
end
