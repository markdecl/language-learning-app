class AddTestDirectionToFlashcard < ActiveRecord::Migration[6.0]
  def change
    add_column :flashcards, :test_direction, :string
  end
end
