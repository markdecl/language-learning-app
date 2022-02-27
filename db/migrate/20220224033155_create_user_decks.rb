class CreateUserDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_decks do |t|

      t.timestamps
    end
  end
end
