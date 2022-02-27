class CreateUserFlashcards < ActiveRecord::Migration[6.0]
  def change
    create_table :user_flashcards do |t|
      t.datetime :next_review
      t.datetime :due_to_learn
      t.boolean :learnt

      t.timestamps
    end
  end
end
