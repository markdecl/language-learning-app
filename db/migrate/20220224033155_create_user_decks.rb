class CreateUserDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_decks do |t|

      t.timestamps
    end
    # add_index :user_decks, :deck_id, unique: true
    add_index :user_decks, [ :deck_id, :user_id ], unique: true
  end
end
