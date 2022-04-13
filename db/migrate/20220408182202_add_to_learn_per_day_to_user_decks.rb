class AddToLearnPerDayToUserDecks < ActiveRecord::Migration[6.0]
  def change
    add_column :user_decks, :to_learn_per_day, :integer
  end
end
